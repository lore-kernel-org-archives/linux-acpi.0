From: Lan Tianyu <tianyu.lan@intel.com>
Subject: Re: [PATCH] ACPI/Battery: Retry to get Battery information if failed
 during probing
Date: Fri, 13 Jun 2014 10:25:00 +0800
Message-ID: <539A60FC.1050301@intel.com>
References: <1402552946-14704-1-git-send-email-tianyu.lan@intel.com> <alpine.DEB.2.02.1406112354070.23724@chino.kir.corp.google.com> <53995488.20308@intel.com> <alpine.DEB.2.02.1406120025050.23724@chino.kir.corp.google.com> <53996152.2000407@intel.com> <alpine.DEB.2.02.1406121415150.8305@chino.kir.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:41752 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750862AbaFMCZs (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 12 Jun 2014 22:25:48 -0400
In-Reply-To: <alpine.DEB.2.02.1406121415150.8305@chino.kir.corp.google.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: David Rientjes <rientjes@google.com>
Cc: rjw@rjwysocki.net, lenb@kernel.org, naszar@ya.ru, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org

On 2014=E5=B9=B406=E6=9C=8813=E6=97=A5 05:17, David Rientjes wrote:
> On Thu, 12 Jun 2014, Lan Tianyu wrote:
>=20
>> The retry time is set by randomly and not accurate because don't kno=
w
>> when EC will work normally. Set the retry time to 5 just in order to
>> make sure battery driver probing sucessfully every time,
>>
>=20
> Ok, I was hoping to avoid the excessive wait if it will never actuall=
y=20
> succeed

Ok. The battery driver has used async init and so this will not affect
the speed of boot up.

> but I assume there's some evidence that it can succeed after 40ms,=20
> 60ms, etc.  Please consider the following instead:
>=20
> 	for (i =3D 0; i < 5; i++) {
> 		/* Comment on why we need a delay in between retries */
> 		if (i)
> 			msleep(20);
> 		result =3D acpi_battery_update(battery, false);
> 		if (!result)
> 			break;
> 	}
>=20

How about this?

-       result =3D acpi_battery_update(battery, false);
-       if (result)
+
+       /*
+        * Some machines'(E,G Lenovo Z480) ECs are not stable
+        * during boot up and this causes battery driver fails to be
+        * probed due to failure of getting battery information
+        * from EC sometimes. After several retries, the operation
+        * may work. So add retry code here and 20ms sleep between
+        * every retries.
+        */
+       while (acpi_battery_update(battery, false) && retry--)
+               msleep(20);
+       if (!retry) {
+               result =3D -ENODEV;
                goto fail;
+       }
+




--=20
Best regards
Tianyu Lan
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
