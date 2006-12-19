From: Corentin CHARY <corentincj@iksaif.net>
Subject: Re: [PATCH 3/22] Remove deprecated parameters
Date: Tue, 19 Dec 2006 23:46:55 +0100
Message-ID: <200612192346.55969.corentincj@iksaif.net>
References: <200612192218.55855.corentincj@iksaif.net> <200612192318.10845.corentincj@iksaif.net> <20061219142216.ad8298f4.randy.dunlap@oracle.com>
Reply-To: corentincj@iksaif.net
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iksaif.dns26.com ([84.246.226.15]:45459 "EHLO iksaif.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932979AbWLSWq5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 19 Dec 2006 17:46:57 -0500
In-Reply-To: <20061219142216.ad8298f4.randy.dunlap@oracle.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: len.brown@intel.com, linux-acpi@vger.kernel.org

Le mardi 19 d=E9cembre 2006 23:22, Randy Dunlap a =E9crit=A0:
> On Tue, 19 Dec 2006 23:18:10 +0100 Corentin CHARY wrote:
> > Just look the code ;)
> >
> > > > -               printk(KERN_WARNING "  asus_uid and asus_gid
> > > > parameters are " -                      "deprecated, use chown =
and
> > > > chmod instead!\n"); -       }
>
> That's really not the right place for it.
> See Documentation/feature-removal-schedule.txt .
>

Yep, you're right, but it should have been added here since January . I=
t's in=20
acpi4asus 0.30, released on 2006-01-17, but I don't know when it had be=
en=20
merged in the kernel. So, maybe we should wait, but I think nobody use =
that=20
(I know it's not a good reason) ...

--=20
CHARY 'Iksaif' Corentin
http://xf.iksaif.net
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
