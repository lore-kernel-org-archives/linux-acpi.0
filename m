From: "Karasyov, Konstantin A" <konstantin.a.karasyov@intel.com>
Subject: RE: Laptop fan on Acer 4061NWLCi
Date: Mon, 3 Apr 2006 19:31:49 +0400
Message-ID: <E124AAE027DA384D8B919F93E4D8C708018E7C54@mssmsx402nb>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:16043 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751724AbWDCPcB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 3 Apr 2006 11:32:01 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Saurabh Nanda <saurabhnanda@gmail.com>, linux-acpi@vger.kernel.org

Hi,

Do you have any devices with 'PNP0C0B' ID in your DSDT? It's associated
with fan in ACPI spec. If you have one there is a chance that you can
assign it to _ALx method in thermal zone.

Do the thermal zone(s) provide other trip points (i.e. passive or
critical)?
Also, some systems provide hardware control to the fan, so the fan turns
on when the temperature high enough.
 
Anyway, sending DSDT would help to clarify the issue. 

Regards.
Konstantin.

>-----Original Message-----
>From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
>owner@vger.kernel.org] On Behalf Of Saurabh Nanda
>Sent: Monday, April 03, 2006 3:08 PM
>To: linux-acpi@vger.kernel.org
>Subject: Laptop fan on Acer 4061NWLCi
>
>Hi,
>
>I have recently bought an Acer 4061NWLCi laptop and am having trouble
>getting ACPI to work. I hope somoene will help me out :-)
>
>I am running Ubuntu Linux -- Breezy Badger 5.10. With the default
>Ubuntu kernel (2.6.12) ACPI did not work at all. I did not even get
>the battery status in GNOME. Then I installed the latest kernel (
>2.6.16.1) and ACPI started working - at least partially! I could check
>my CPU temperature, AC adapter status, and battery status.
>
>The only thing not working is the CPU fan. I tried reading through my
>current(broken) DSDT and surprisingly there is no mention of a fan
>anywhere! In the Thermal Zone configuration there is no mention of
>_ACx (_AC0, _AC1, etc.) as well. I can post my DSDT to the list if it
>would help.
>
>Can anyone please help me in fixing this? Running my laptop without a
>fan is pretty dangerous as the CPU temperatures crosses 65 degrees
>celcius at times.
>
>Can I declare a fan and an active cooling temperature point in the
>DSDT, recompile it and hope that it would work? Has anyone else done
>this kind of a thing before?
>
>TIA
>Nandz,
>--
>http://nandz.blogspot.com
>http://foodieforlife.blogspot.com
>-
>To unsubscribe from this list: send the line "unsubscribe linux-acpi"
in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
