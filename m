From: Norbert Preining <preining@logic.at>
Subject: Re: [PATCH] sony-laptop: support rfkill via ACPI interfaces
Date: Thu, 19 Mar 2009 23:15:27 +0100
Message-ID: <20090319221527.GA11001@gamma.logic.tuwien.ac.at>
References: <20090319212123.GA24700@srcf.ucam.org> <20090319213428.GK29624@gamma.logic.tuwien.ac.at> <20090319214437.GB24898@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx.logic.tuwien.ac.at ([128.130.175.19]:39776 "EHLO
	mx.logic.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756163AbZCSWPk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 19 Mar 2009 18:15:40 -0400
Content-Disposition: inline
In-Reply-To: <20090319214437.GB24898@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: malattia@linux.it, linux-acpi@vger.kernel.org

Hi Matthew,

On Do, 19 M=E4r 2009, Matthew Garrett wrote:
> > > Enable events on all Vaio's with the new-style ACPI interface, an=
d use
> > > it to support rfkill where available.
> >=20
> > Thanks for these patches, do they enable wwan activation on Vaio Z
> > series, too?
>=20
> I expect so.

Ok, here some first test result:
kernel 2.6.29-rc8 plus only your patch.

Nice.

Now I have loads of rfkill switches:
/sys/class/rfkill# for i in rfkill*/name ; do echo $i; cat $i; done
rfkill10/name
5100AGN
rfkill11/name
sony-wifi
rfkill12/name
sony-bluetooth
rfkill13/name
sony-wwan
rfkill15/name
hso-0


The interesting thing is that the last one hso-0 does not do anything
when echoing 0/1 onto the state, while echoing 0/1 onto rfkill13/state
the device is actually dis/enabled.

=46ine.

Especially since I can now also turn on and off the bluetooth device.
Great.

Thanks a lot!

Best wishes

Norbert

-----------------------------------------------------------------------=
--------
Dr. Norbert Preining <preining@logic.at>        Vienna University of Te=
chnology
Debian Developer <preining@debian.org>                         Debian T=
eX Group
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 0=
9C5 B094
-----------------------------------------------------------------------=
--------
CLACKMANNAN (n.)
The sound made by knocking over an elephant's-foot umbrella stand full
of walking sticks. Hence name for a particular kind of disco drum
riff.
			--- Douglas Adams, The Meaning of Liff
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
