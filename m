From: "Renato S. Yamane" <yamane@diamondcut.com.br>
Subject: Re: Toshiba - Documentation for Linux Developers
Date: Wed, 18 Jun 2008 08:22:31 -0300
Message-ID: <4858EFF7.5000107@diamondcut.com.br>
References: <4855971D.90004@diamondcut.com.br> <20080616221443.GA760@kroah.com> <485799B6.2010302@diamondcut.com.br> <200806181311.34849.damnshock@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-02.mandic.com.br ([200.225.81.133]:48784 "EHLO
	smtp-02.mandic.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752739AbYFRLWl (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 18 Jun 2008 07:22:41 -0400
In-Reply-To: <200806181311.34849.damnshock@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: =?ISO-8859-1?Q?Marc_Deop_i_Argem=ED?= <damnshock@gmail.com>
Cc: linux-acpi@vger.kernel.org, greg@kroah.com, mjg59@srcf.ucam.org, lenb@kernel.org

Marc Deop i Argem=ED wrote:
> Renato S. Yamane wrote:
>> With no Fn keys, I can't change brightness of monitor (Fn+F6/F7) and
>> change output video from LCD to VGA (Fn+F5).
>>
>> I try use "xev" to capture key press, but Fn and Multimedia Keys is =
not
>> recognized.
>=20
> Have you tried if your system is playing them as acpi events?=20
> cat /proc/acpi/events
>=20
> and then press the keys. Is there any output?

# cat /proc/acpi/event
cat: /proc/acpi/event: Device or resource is busy

ls -la /proc/acpi/event
-r-------- 1 root root 0 Jun 18 07:39 /proc/acpi/event

Best regards,
Renato S. Yamane
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
