From: Oeystein Olsen <oystein.olsen-rcBQPNaXqvV2YatnTvQNog@public.gmane.org>
Subject: Re: Acpi on compaq evo N1000v
Date: Tue, 13 May 2003 15:02:32 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200305131502.32509.oystein.olsen@astro.uio.no>
References: <3ACA40606221794F80A5670F0AF15F842722FA@pdsmsx403.ccr.corp.intel.com> <200305131113.29470.oystein.olsen@astro.uio.no>
Reply-To: oystein.olsen-rcBQPNaXqvV2YatnTvQNog@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200305131113.29470.oystein.olsen-rcBQPNaXqvV2YatnTvQNog@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tuesday 13 May 2003 11:13, Oeystein Olsen wrote:
> On Tuesday 13 May 2003 08:33, Yu, Luming wrote:
> > Currently, I want to find out  what causes battery missing on (Presario
> > 1500, 1505, 2800T). I looked into your fixes in 007dsdt, and found that
> > the changes in method C0CF._REG() could take effect to your original
> > problem. To verify it, could you please only apply below change in
> > C0CF._REG().
> >
> > -                            If (LAnd (Arg1, LNot (LLess (\C009 (),
> > 0x03)))) +                            If (Arg1)
>
> With this change to my orignal dsdt-table, battery-status works on my
> laptop. [I also had to change *PNP to PNP to make it work.]

Me again.

The above change gave me an idea about the error-message I got at boot. A 
small change to the C0CF._INI() and the error-message at boot went away:-)
The newest dsdt-table has been uploaded to acpi.sourceforge.net, and also 
available from 

http://folk.uio.no/oeysteio/Compaq/DSDT/

The newest version is 009.

-- 
Øystein Olsen, oystein.olsen-rcBQPNaXqvV2YatnTvQNog@public.gmane.org, http://folk.uio.no/oeysteio
Institute of Theoretical Astrophysics, http://www.astro.uio.no
University of Oslo, Norway


-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
