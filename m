From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: ACPI-Patch against 2.4.20-pre10-ac1
Date: Mon, 14 Oct 2002 11:24:35 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021014092435.GG22361@poup.poupinou.org>
References: <20021011183427.20a55d1c.hanno@gmx.de> <1034372783.12355.4.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1034372783.12355.4.camel-MMxVpc8zpTQVh3rx8e9g/fyykp6/JSeS3vcXtXqGYxw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Cc: Hanno =?iso-8859-1?Q?B=F6ck?= <hanno-Mmb7MZpHnFY@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi Alan,

On Fri, Oct 11, 2002 at 10:46:23PM +0100, Alan Cox wrote:
> On Fri, 2002-10-11 at 17:34, Hanno Böck wrote:
> > I tried to apply the acpi-patch against 2.4.20-pre10-ac1.
> > 
> > It is not perfect, there are some problems with cpufreq i couldn't fix. If you disable cpufreq, it should compile and run.
> > 
> > If anyone fixes the cpufreq-issue, please inform me.
> 
> You don't want to mix the two. If you do need native power management on
> your ACPI system the ACPI layer eventually has to be the one making the
> cpufreq requests

You _do_ want to mix the two when ACPI didn't have the right
information in order to support performance states of the cpu (old
version of the specs where performance is not included in AML).

Please note also that Dominik have submitted some patches to have
the two in order to cooporate more smoothly, and Andy is agreed to
go, when things would stabilize.

Cheers,

-- 
Ducrot Bruno
http://www.poupinou.org        Page profaissionelle
http://toto.tu-me-saoules.com  Haume page


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
