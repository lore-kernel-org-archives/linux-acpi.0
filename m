From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [ACPI] Re: [RFC] Reliable video POSTing on resume
Date: Sat, 5 Feb 2005 12:38:07 -0500
Message-ID: <9e47339105020509382adbbf39@mail.gmail.com>
References: <20050122134205.GA9354@wsc-gmbh.de>
	 <4204B3C1.80706@rainbow-software.org>
	 <9e473391050205074769e4f10@mail.gmail.com>
	 <200502051748.43547.stefandoesinger@gmx.at>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
In-Reply-To: <200502051748.43547.stefandoesinger@gmx.at>
Sender: linux-kernel-owner@vger.kernel.org
To: =?ISO-8859-1?Q?Stefan_D=F6singer?= <stefandoesinger@gmx.at>
Cc: acpi-devel@lists.sourceforge.net, Ondrej Zary <linux@rainbow-software.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Pavel Machek <pavel@ucw.cz>, Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>, ncunningham@linuxmail.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Sat, 5 Feb 2005 17:48:43 +0100, Stefan D=F6singer
<stefandoesinger@gmx.at> wrote:
> The reset code of radeon card seems to be easy to reverse engineer. I=
 have
> started an attempt and I have 50-60% of my radeon M9 reset code imple=
mented
> in a 32 bit C program. I had to stop due to school reasons.

The problem with the radeon reset code is that there are many, many
variations of the radeon chips, including different steppings of the
same part. The ROM is matched to the paticular bugs of the chip. From
what I know ATI doesn't even have a universal radeon reset program.

--=20
Jon Smirl
jonsmirl@gmail.com
