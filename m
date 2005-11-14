From: marek czardybon <max-MEOeS5c08o1g9hUCZPvPmw@public.gmane.org>
Subject: Re: broken acpi support for battery 2.6.14
Date: Mon, 14 Nov 2005 08:34:52 +0100
Message-ID: <43783E1C.4040409@inbox.eu.org>
References: <baf307070511130204h31c7f6bfv35067ce4c53fd868@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <baf307070511130204h31c7f6bfv35067ce4c53fd868-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: Kevin Verma <kevinverma-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Dnia 2005-11-13 11:04, Kevin Verma napisa=B3:
> Hello,
>=20
> I am continuesly noticing that the battery status being shown as NA
> and it is not possible to see the charge remaining via "Gnome battery
> charge monitor" while the output from /proc FS  and dmesg are as below
> :
> --------------------
> [root@localhost /]# cat /proc/acpi/battery/BAT0/info
> present:                 yes
> ERROR: Unable to read battery information
[cut]

I've the same problem.
the solve was this patch http://bugzilla.kernel.org/show_bug.cgi?id=3D532=
2

With regards.
--=20
marek czardybon / maxilee   +48 0697 724 404       http://inbox.eu.org
GG:3299479 JAB:maxilee-veJsmC5npURmR6Xm/wNWPw@public.gmane.org                  http://outbox.eu.org
ARP: 00:C0:9F:AA:EB:3F         GCC d? s:- a- C+++ UL++ P++ L++ E--- W+
N+ o K w--- O M- V- PS+ PE+ Y PGP t 5 X+R+ !tv b+ DI- D++ G e h r++ y?


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
