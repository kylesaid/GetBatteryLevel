using UnityEngine;
using System.Collections;
using System;
using System.Runtime.InteropServices;
using UnityEngine.UI;

public class GetBattery : MonoBehaviour
{
	[DllImport("__Internal")]
	private static extern float getiOSBatteryLevel();

	string _time = string.Empty;
	string _battery = string.Empty;
	public Text showText;

	void Start()
	{
		StartCoroutine("UpdataBattery");
	}

	public void getBatte(){

        StartCoroutine("UpdataBattery");
	}

	IEnumerator UpdataBattery()
	{
		while (true)
		{

#if UNITY_IPHONE
			float level = getiOSBatteryLevel() * 100;
			print("level" + level);
			showText.text = level.ToString();

#else
			showText.text = GetBatteryLevel().ToString();

#endif
			//showText.text = _battery;
			print("battery::::" + showText.text + "%");
			yield return new WaitForSeconds(300f);
		}
	}


	int GetBatteryLevel()
	{
		try
		{
			string CapacityString = System.IO.File.ReadAllText("/sys/class/power_supply/battery/capacity");
			return int.Parse(CapacityString);
		}
		catch (Exception e)
		{
			Debug.Log("Failed to read battery power; " + e.Message);
		}
		return -1;
	}
}