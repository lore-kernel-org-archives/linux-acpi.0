From: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>
Subject: Re: broken bm_sts on 82801CA?
Date: Fri, 10 Oct 2003 12:35:01 -0700 (PDT)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031010123339.D17381@root.org>
References: <20031006233406.N4792@root.org> <20031007085536.GB11391@poupinou.org>
 <20031007110948.V6708@root.org> <20031008123103.GG11391@poupinou.org>
 <20031008095321.B10515@root.org> <20031008172800.GI11391@poupinou.org>
 <20031008103531.B10689@root.org> <20031010105834.GM11391@poupinou.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20031010105834.GM11391-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Fri, 10 Oct 2003, Ducrot Bruno wrote:
> On Wed, Oct 08, 2003 at 10:40:21AM -0700, Nate Lawson wrote:
> > However, since this code is run every time acpi_processor_idle() is
> > called, it will never enter even C2 if you have a bm_sts bit that is
> > always 1.
>
> I checked a little bit more, but I think you are wrong because
> acpi_processor_power_activate(pr, next_state), with next_state == ACPI_STATE_C2,
> will be called after the end label,
> and since pr->power.states[ACPI_STATE_C2].demotion.threshold.bm
> is always 0 we do not go to the 'then' statement at the next run if we
> were at C3 state.

Yes, I was incorrect.  It should always go to C2.

-Nate


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
