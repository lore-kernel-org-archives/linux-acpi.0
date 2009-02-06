From: yakui_zhao <yakui.zhao@intel.com>
Subject: Re: [BUG?] Critical temperature shutdowns on ThinkPad X60 1706-GMG
Date: Fri, 06 Feb 2009 09:31:53 +0800
Message-ID: <1233883913.3625.14.camel@localhost.localdomain>
References: <878wokssga.fsf@gismo.pca.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:29842 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752308AbZBFBUS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 5 Feb 2009 20:20:18 -0500
In-Reply-To: <878wokssga.fsf@gismo.pca.it>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Luca Capello <luca@pca.it>
Cc: ML Linux-ACPI <linux-acpi@vger.kernel.org>

On Fri, 2009-02-06 at 01:29 +0800, Luca Capello wrote:
> Hi there!
>=20
> In July 2008 I reported a problem about critical temperature shutdown=
s:
>=20
>   http://news.gmane.org/find-root.php?message_id=3D%3c87zlnyv14h.fsf%=
5f%2d%5f%40gismo.pca.it%3e
>=20
> Since I was not the only one experiencing it, reading the mailing lis=
t I
> had the impression it had been solved since then.
>=20
> And indeed I do not remember I have experienced it again.  However, t=
he
> last week it reappeared, probably because in the meantime I have not
> used my laptop at full power :-(
>=20
> Anyway, here we are:
>=20
> - I got 6 "Critical temperature reached (128 C), shutting down"
>   experiences since January 30th
The Critical shutdown threshold is 128. In fact it is quite high.=20
In fact only when the actual temperature is above 128, the following
message will be complained and the box will be shutdown.
   >=EF=BB=BFCritical temperature reached (128 C), shutting down

Will you please attach the output of acpidump? Let's check whether the
temperature is obtained by using EC.
   Thanks.
>=20
> - when I know that temperature could rise (e.g. using QEMU to build
>   Debian packages for armel), I usually set the fan at maximum speed
>=20
>     $ echo -n "level full-speed" >/proc/acpi/ibm/fan
>=20
>   However, the last time (10 minutes ago) happened even with that
>   setting and my setup was:
>=20
>   * my usual Emacs session
>   * Conkeror
>   * a git-buildpackage process (basically building a Debian package f=
rom
>     a Git repository and inside a chroot)
>   * the Openmoko FreeRunner was plugged to the left USB port and char=
ging
>   * on one of the right port there was an Eutronsec SIMReaderCombo,
>     basically an OmniKey CardMan 6121 USB SIM-sized smartcard reader
>     coupled with a 2GB flash memory (in my case this is SLC, more
>     information at http://www.eutronsec.it/ )
>   * the laptop is placed on a scientific laboratory desk and the airf=
low
>     from the fan grid is free to circulate
>   * the laptop is on AC power with no battery inserted
>=20
> - the last was on Debian kernel 2.6.28-1~experimental.1~snapshot.1267=
4;
>   since I am preparing for FOSDEM, I do not have time right now to te=
st
>   a vanilla kernel, but I will do starting from next Monday.  Which
>   kernel version should I test first, 2.6.28.3?
>=20
> That is all, I think.  Feel free to ask for more inforation/test.
>=20
> Thx, bye,
> Gismo / Luca

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
