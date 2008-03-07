From: "Zhang, Rui" <rui.zhang@intel.com>
Subject: RE: *NEW* ACPI driver to support App Hot Startup AKA PNP0C32 - please apply
Date: Fri, 7 Mar 2008 14:27:13 +0800
Message-ID: <823A93EED437D048963A3697DB0E35DE0129BE5A@pdsmsx414.ccr.corp.intel.com>
References: <20071110014448.471e384b.miknix@gmail.com><200711100321.22500.carlos@strangeworlds.co.uk><20071112000534.e0489eca.miknix@gmail.com><200711120002.24474.carlos@strangeworlds.co.uk><20071123152446.144ac193.miknix@gmail.com> <20080119151929.1674103b.miknix@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:17363 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751219AbYCGG2x convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 7 Mar 2008 01:28:53 -0500
Content-class: urn:content-classes:message
In-Reply-To: <20080119151929.1674103b.miknix@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: =?iso-8859-1?Q?=C2ngelo_Miguel_Arrifano?= <miknix@gmail.com>, lenb@kernel.org
Cc: linux-acpi@vger.kernel.org

Hi, Angelo,

=46or a typical ACPI device driver, it usually works like this:
1. Register the ACPI device driver is the module_init
2. Enable the device, create the sys I/F in the drivers .add method.
3. Remove the device I/F in .remove method.
4. unregister the ACPI device driver in module_exit.

With your patch applied, the sys I/F will be created even if no PNP0C32=
 device exists in the ACPI namespace. IMO, moving this piece of code to=
 the .add method will be much better.

BTW: please don't send a patch as an attachment, it's difficult for rev=
iew. :)

Thanks,
rui

>-----Original Message-----
>From: linux-acpi-owner@vger.kernel.org
>[mailto:linux-acpi-owner@vger.kernel.org] On Behalf Of ?ngelo Miguel A=
rrifano
>Sent: Saturday, January 19, 2008 11:19 PM
>To: lenb@kernel.org
>Cc: linux-acpi@vger.kernel.org
>Subject: Re: *NEW* ACPI driver to support App Hot Startup AKA PNP0C32 =
- please
>apply
>
>-----BEGIN PGP SIGNED MESSAGE-----
>Hash: SHA1
>
>On Fri, 23 Nov 2007 15:24:46 +0000
>=C2ngelo Miguel Arrifano <miknix@gmail.com> wrote:
>
>> Hello all,
>>
>> I opened a SF.net project to support devices found under PNP0C32.
>> These devices are known as Direct App Launch Buttons and are used on=
 Vista
>Hotstart(TM) technology.
>> I believe most of Vista "ready" laptops have this.
>>
>> The project aims to provide similar functionality to Vista Hotstart(=
TM) in
>linux.
>> You can read more at http://quickstart.sourceforge.net/
>>
>> Greetings,
>> --
>> Angelo Arrifano AKA MiKNiX
>> CSE Student at UBI, Portugal
>> Gentoo Linux AMD64 Arch Tester
>> miknix@gmail.com
>> http://miknix.homelinux.com
>> PGP Pubkey online
>>
>> - -
>>
>> Q: How many Chuck Norris' does it take to change a light bulb?
>> A: None, Chuck Norris prefers to kill in the dark.
>
>The project is running for some time now. During this time there
>were no reports of people getting it trouble with it.
>
>Attached is the patch.
>
>Thanks,
>- --
>Angelo Arrifano AKA MiKNiX
>CSE Student at UBI, Portugal
>Gentoo Linux AMD64 Arch Tester
>Linwizard Developer
>miknix@gmail.com
>http://miknix.homelinux.com
>PGP Pubkey 0x3D92BB0B
>-----BEGIN PGP SIGNATURE-----
>Version: GnuPG v2.0.7 (GNU/Linux)
>
>iD8DBQFHkhUBNahyoD2SuwsRAn8gAJ4yj/kQl3RyAbBw3s9/2R04rEjFbQCfc1fC
>/HlHqqB8B9my/vP67QMWrBM=3D
>=3DnVRr
>-----END PGP SIGNATURE-----
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
