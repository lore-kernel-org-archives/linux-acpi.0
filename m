From: Derek Broughton <dbroughton-F3m4/jXepmf3fQ9qLvQP4Q@public.gmane.org>
Subject: Re: [ACPI-sppt] Missing C states & thermal stuff on P4M
Date: Mon, 16 Jun 2003 13:33:41 -0300
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <004801c33425$0bbf0c10$3746028e@bio.dfo.ca>
References: <Pine.LNX.4.44.0306161337190.10380-100000@zupcx1.star.ucl.ac.uk>
 <000f01c3340c$2cf966a0$3746028e@bio.dfo.ca>
 <Pine.LNX.4.53.0306161714570.10959@fls-nb>
Mime-Version: 1.0
Content-Type: text/plain;	charset="Windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ACPI Development - Sourceforge <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

From: "Florian Streibelt" <acpi-FcBgPhobQO3YWZAotbjKIA@public.gmane.org>
>
> > > cpufreq: Intel(R) SpeedStep(TM) for this chipset not (yet) available.
> >
> > Not ACPI related, but indicating that there's no support for controlling
> > frequency in Linux.
>
> I think that means that the cpufreq kernel-patch is not able to control
> the processor speed. But ACPI may be able to do so.
>
> I have a Mobile Intel(R) Pentium(R) 4 - M CPU 2.00GHz and I am getting
> the same message, when using a kernel with that patch.
> But I am able to throttle the CPU via ACPI-Interface by doing
> echo "7" > /proc/acpi/processor/CPU/throttlin
> or any other number between 0-7.

In fact, his does appear to support throttling - so does my Celeron.  iirc, this
isn't frequency related, but I'm getting out of my depth now :-).

derek



-------------------------------------------------------
This SF.NET email is sponsored by: eBay
Great deals on office technology -- on eBay now! Click here:
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
