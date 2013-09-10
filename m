From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: Re: loading 'acpiphp' fails =?utf-8?Q?afte?=
 =?utf-8?B?ciB0aGUgc3lzdGVtIGJvb3Q/4oCP?=
Date: Tue, 10 Sep 2013 08:51:03 -0700
Message-ID: <20130910155103.GB22628@kroah.com>
References: <SNT149-W205633FE9047D530867E639A380@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:36956 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753204Ab3IJPvF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 10 Sep 2013 11:51:05 -0400
Content-Disposition: inline
In-Reply-To: <SNT149-W205633FE9047D530867E639A380@phx.gbl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Shiro Itou =?utf-8?B?5LyK5p2x?= <shiro.itou@outlook.com>
Cc: "linux-hotplug@vger.kernel.org" <linux-hotplug@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Tue, Sep 10, 2013 at 08:43:05AM -0700, Shiro Itou =E4=BC=8A=E6=9D=B1=
 wrote:
> Hi All,
> =C2=A0
> In kernel version 3.0, when =E2=80=98apciphp=E2=80=99 driver module i=
s loaded, after
> the system comes up, it fails with error =E2=80=9Cno such device=E2=80=
=9D. When I
> tried to debug I see that it fails in acpiphp_get_num_slots ()
> function with error "Total 0 slots". In this case =E2=80=98bridge_lis=
t=E2=80=99 =C2=A0seem
> to be NULL.  =C2=A0
> But when the =E2=80=98acpiphp=E2=80=99 is loaded during boot time, =C2=
=A0it seems to work file.

What happens in the 3.11 kernel release?  Lots of work has been done in
this area in the past 2 years, please try a newer kernel.  If there are
still problems, please let the linux-pci@vger.kernel.org mailing list
know about it.

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
