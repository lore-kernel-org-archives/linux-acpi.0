From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: RE: 'rmmod button' doesn't remove /proc/acpi/button
Date: Mon, 11 Nov 2002 12:48:27 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <EDC461A30AC4D511ADE10002A5072CAD04C7A4EA@orsmsx119.jf.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C289C3.AF5841A0"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "'Cagle, John (ISS-Houston)'" <john.cagle-VXdhtT5mjnY@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C289C3.AF5841A0
Content-Type: text/plain

> From: Cagle, John (ISS-Houston) [mailto:john.cagle-VXdhtT5mjnY@public.gmane.org] 
> Actually, all the other client drivers had code to remove
> the class proc entry -- it was only missing from button.c's 
> unload logic.

I think they're not quite right...

> > I think the best thing is to make the semantics "the proc dir
> > is there if the driver is loaded, even with no devices 
> > present" instead of "the proc dir is there only if an actual 
> > instance of the device is present".
> > This allows us to move the creation of the dir to the driver
> > init function, instead of the device add function.

> That does sound like a cleaner approach.  Let me try it out
> and see what the patch looks like.

I've generated the attached patch (against 2.4-acpi but should apply to
2.5). Does it fix the problem? If not, it should at least be a starting
point.

Regards -- Andy


------_=_NextPart_000_01C289C3.AF5841A0
Content-Type: application/octet-stream;
	name="proc_cng.diff.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="proc_cng.diff.gz"

H4sICDkW0D0AA3Byb2NfY25nLmRpZmYAzZptc9o4EIA/w6/Q9UMHamgsyy/gXm5CEzplJg2dhLbT
Tx4KSs9zDWRsk16u0/9+evGLjG1ZNkwmmUwAWburXUnPrkROT8kPWAf+Aw7Ck+Xq3id/Xq8AfA3B
Qwjw2o/wGtBOp93hcEjbTwq9O19In8nuO4AmgMg1ye8YGLpudDVNi3WUSH3YbsDV9gFACKDhQsvV
LS51dgaG0IIDaACNvtrg7KwLuqAzOf848959ujpfzOZX3uJ6cj7tvaAKveXKW67X3m34ov+GdB12
/FvQ+yN5tPaDPvhFWjtCCzgF98F25d39Qz70mOrJuXd+Obm5GQDWL9huIyb7hooWNNLGToCjXbDx
Pk8uP017w+nV/GL6mfX/3R2SEWdCa/zgrzAV7PG3fTokEA+p+DQ/PLHTN3+ddBpQBaJTxDSL3sge
jEnwRnocvF910Qvw3fYBywJI3a3yNva0ylE6ytgA8wlvouCx0ieQ9wcwj5BhEFc0BNEA6krrwd/4
EXdGaz3tWkkYtMowaGRIAQ53PyJihMl824Ukst/9MMKBx3dA72WqjX2mI2RWYsk/gR4vjGLEakbL
4oSsAUQkUEgfkI1FA/Ww9dfA8/C/ftRNY0s/gR591O+yreFvIrac4+HrfFalEaY6kuVS9Hu3qfc8
XmZcOF5hDZ2OJ1fVokYEGtsAbGL5nM9nF6Thd/e0SM5vy4jYfmyCz1SkOUMz0QJILSMDqa2bDKT0
VQGksdZKmibP95AqNJdssLeTxWJ6/VUJrqKB50VYcWR8s9m2STFrWyMlzCYKJKzd9/4JgZt3j1N3
pNPsqzljQ4m6iYoCeg9aHlpVfI5D4lRlOxzXDJ5FEZqMySN9nDA5jJaRvypBczKag/ksKmoO6UJQ
lEldO5nNbUuYXWNNFdy7KNpuGnE7lmiB7UQyT23dzlEbQoeXv+Q1pTYXTaaPa/XWy2iZ7OQCTZhA
gdVpa9le/LRYkJWkROpMuwqow59+tPob9LjY8K/o8R7zrbVahhiI1hdfP069j/Mv02tX/vidy6Nl
83LXVit344HLMJx37SkpnFlOIGyS0pd4Z9LS11KAMNdQZHD7adcqQnMkAMca86gR+BvbzxNZqyaQ
1BdQPWayUEVgsMd6n0GDzQOyaTI0ERqM2DTUT0IGX6DAvb04yLAnd1GNepgf9I0K4hknhd6dxQ6D
+SoChgGg7cKRixw57XDxoG8g1zAz0pmOwUhHXxXqU1x90MeFgz6uOvFN1Q76+Dke9LF40Ld0xKM3
dpTQh6Unfaxw0h/KkVdaGMiRlzo0rNh8HIPOiN0AOI6uVIvikhuAFutBKwnPcbCHW98AVI+W1+yj
AalGSLUpuQHAR7gBwG1vAHCbGwDZFDWyCKqxWm0jBTh1erWOmOc99qCErLfLRsUk616sJC1dzlYu
tgdXyzVtoYw0bV5GmnaMBx7ueAOWJMPZFXlXAAMxtc/WuKlkM72bqNWPidLnhddkVMlFKqu9oGMr
4ZUKS/gqevyENWXmEiep4UDqlGEbSgUlFS+gtNX0a2WxOA5NmbpjVZASF9qXjwZZSvQWwHDG1Vym
bhwM5kRJczKXRFEBzdIZb2ZTUvPKJkWt4L3f/sRBk5o3FsiVvY5rIRcacjQngntwdlwEhcoXcTjz
c0V7ODNj+3hOG0t2KDs6KyE6U/28IJ2N6018iGBEM21LCdNcXALqvN9PiGrRMQ5ri5e9liN+8TW7
mi28y9nNwns/nVzEGynxKtzuAqL8B9lrIrFbrwitPDDH4XassF0hLB02C97YoilOs8Y6ZW85c/kQ
DqZupiY58Z+8Aou3Fy6Y3t1Hj6BqjsCrk4aU3ouZMqdrZrmpXQmrpZZUaU104jDcNiN2JpRSG0Ba
UEPLhXYNtQXhPXKPXaQLZfXY4jf67I3CrUWqufLyIuuxD3LxQdnWvZ6fT29u5mm4GanlVM/ZemZk
z42N72JDN3nBqiNTje+pEhnjC1F4Ss7vuRkX5sbYYY4aIycpzTt3+C7EUe9lKhIOgD4Aof8f3t72
stY+w2fSGwfBMlqKPXlLP5cSmq4taWrIx/NI6SFTeqzivtapA0p8RO9eaI2P6LfuNV/1Zb4dnnty
qprX/ZVhVskq9YukjX1ZdqmdQbUME/2Ng7vlD5ZfzIr8Yp6Ui+Syi+XqI9cy5dklE83nFqS7lviP
b7rJ/4OHvVHILbHeysySPN/LK0Jzyc5fvJ9ef5hcqucU0crzyijiyOJLHYj4rQ401M4LiQpJNtn3
/wlzSd5BnkkgQvwrUWTYSpc8iZLCRU+jdSLLD7kIHSc7pCqPlRtq3GmfGSAyHb6rkYlqM0Pi18F5
QVTUPCtUhFchJ9Qui+a2JfmgbtZKssH/saUCq/gsAAA=

------_=_NextPart_000_01C289C3.AF5841A0--


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
