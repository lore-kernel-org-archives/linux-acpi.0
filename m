From: "Sylvain Bertrand" <sylvain.bertrand@gmail.com>
Subject: Re: ACPI Exception (acpi_thermal-0412)
Date: Thu, 21 Sep 2006 00:52:43 +0200
Message-ID: <d512a4f30609201552t388734aby3863aacf6617465d@mail.gmail.com>
References: <200609141951_MC3-1-CB3C-3653@compuserve.com>
	 <1158715360.3098.22.camel@localhost.portugal>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:45835 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932440AbWITWwp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 20 Sep 2006 18:52:45 -0400
Received: by ug-out-1314.google.com with SMTP id o38so59559ugd
        for <linux-acpi@vger.kernel.org>; Wed, 20 Sep 2006 15:52:44 -0700 (PDT)
In-Reply-To: <1158715360.3098.22.camel@localhost.portugal>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,
Sorry to interfere, but I have the same issue. After code
investigation and ACPI specs reading, it seems that it could be
related to a bug in your ACPI dsdt.
On my laptop, I have only _AC0(hardcoded to rougthly 70=B0). I miss its
mandatory  sibling _AL0 which generates the message when my temp is
going above the threshold it holds.

Regards,

   Sylvain

2006/9/20, Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>:
> Hi, I think this should be reported on
> ACPI mailing list , so I am Forwarding to this list
>
> On Thu, 2006-09-14 at 19:47 -0400, Chuck Ebbert wrote:
> > I get this message at boot on 2.6.18-rc6:
> >
> >  ACPI Exception (acpi_thermal-0412): AE_NOT_FOUND, Invalid active t=
hreshold [0] [20060707]
> >
> > Followed by:
> >
> >  ACPI: Thermal Zone [THRM] (47 C)
> >
> > And looking in /proc/acpi/thermal_zone/THRM/cooling_mode, I see:
> >
> > <setting not supported>
> > cooling mode:   passive
> >
> > The fan seems to run at low speed even when CPU temp is stable at 3=
7C,
> > and speeds up when it gets warmer, so there seems to be no overheat=
ing
> > problem (highest temp seen under full load is 60C.)
> >
> > Is this normal?
> >
> --
> S=E9rgio M.B.
>
>
>
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
