From: Stefan =?iso-8859-1?q?D=F6singer?= <stefandoesinger-RbZlAiThDcE@public.gmane.org>
Subject: Re: S3, SuSE Linux 9.1, Dell Dimension 8300
Date: Wed, 29 Dec 2004 21:09:54 +0100
Message-ID: <200412292109.55022.stefandoesinger@gmx.at>
References: <1104275510.41d1e83630f26@webmail.telering.at>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1104275510.41d1e83630f26-2RFepEojUI04Gyxg+fu0s+Tv7YV0F9Eg@public.gmane.org>
Content-Disposition: inline
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
Cc: Stefan Lintner <stefan.lintner-OBssYPn7tLPk7+2FdBfRIA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


> I am using SuSE Linux 9.1 and would like to use S3 on my home Dell
> Dimension 8300 desktop PC. S3 works fine in WinXP.
>
> Unfortunately the SuSE handbook says that S3 is currently not
> supported on Intel Pentium 4 HT systems. There are also problems if
> AGP modules are loaded - I have such a module loaded: \"intel_mch_agp\"
>
> System:
> Dell Dimension 8300, A07 Bios
> Intel 875P chipset, Intel Pentium 4 HT 2,6GHz
> 1024MB RAM
> NVidia GeforceFX 5200
> Maxtor 6Y080LO HDD
>
> If I press the power button the PC shuts down.
>
> Is it possible to use S3 on this machine?
>
Did you try echo 3  > /proc/acpi/sleep

Stefan D=F6singer


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
