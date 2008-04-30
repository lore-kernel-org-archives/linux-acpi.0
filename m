From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Overriding ACPI tables
Date: Wed, 30 Apr 2008 10:56:33 -0700
Message-ID: <4818B2D1.30209@zytor.com>
References: <48144209.7080203@gmail.com>	 <1209476717.1784.853.camel@queen.suse.de>  <4817457C.6000103@gmail.com>	 <1209493771.1784.892.camel@queen.suse.de>  <4817B0E1.7080102@zytor.com> <1209544792.29352.78.camel@linux-2bdv.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:54350 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751715AbYD3R4o (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 30 Apr 2008 13:56:44 -0400
In-Reply-To: <1209544792.29352.78.camel@linux-2bdv.site>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: trenn@suse.de
Cc: Richard <tuxbox.guru@gmail.com>, linux-acpi@vger.kernel.org, "Langsdorf, Mark" <mark.langsdorf@amd.com>, andreas.herrmann3@amd.com

Thomas Renninger wrote:
> Peter: You wrote the syslinux stuff, right? What kind of luck is that=
 :)
> There currently is a discussion about being able to override ACPI tab=
les
> via initrd. The discussion is a bit stuck because the data is needed
> earlier than initrd is unpacked and the hacks to make it work are not
> accepted by Linus. I thought about adding another binary image to i38=
6
> boot protocol, similar to initrd=3D which contains data for very earl=
y
> kernel boot initialization, but this would be a heavy hammer (but IMO
> still better than only do it for kexec, another suggestion...) , =EF=BB=
=BFI
> better open a separate thread or pre-ask privately whether this makes
> sense at all. It would be great if you could advise and possibly help=
 to
> convince so that we finally may find a solution accepted mainline.

We're putting in a mechanism for pushing larger tables already; we need=
=20
it for other things (in particular, the zones for E820 and EDD in the=20
boot_info_table are simply not big enough.)  That gives a generic=20
mechanism for sending arbitrary-sized binary images to the kernel.  Tha=
t=20
would be the mechanism to use.

I believe it's in upstream as this merge window; it's definitely in=20
x86.git already.

	-hpa
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
