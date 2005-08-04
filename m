From: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
Subject: Re: Linux v2.6.13-rc3
Date: Thu, 4 Aug 2005 14:04:59 -0700
Message-ID: <20050804140459.2ffd4bd3.akpm@osdl.org>
References: <Pine.LNX.4.58.0507122157070.17536@g5.osdl.org>
	<20050714001843.3c14d071.mailing@wodkahexe.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050714001843.3c14d071.mailing-HmhXUwHVxSOoYr4blSSd5g@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Sebastian Kaergel <mailing-HmhXUwHVxSOoYr4blSSd5g@public.gmane.org>
Cc: torvalds-3NddpPZAyC0@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Sebastian Kaergel <mailing-HmhXUwHVxSOoYr4blSSd5g@public.gmane.org> wrote:
>
> On Tue, 12 Jul 2005 22:05:00 -0700 (PDT)
> Linus Torvalds <torvalds-3NddpPZAyC0@public.gmane.org> wrote:
> 
> > Dmitry Torokhov:
> >   [ACPI] Enable EC Burst Mode
> 
> After booting 2.6.13-rc3 on my acer travlemate 291LCI it starts
> complaining:
> 
>  acpi_ec-0217 [30] acpi_ec_leave_burst_mo: ------->status fail
>  acpi_ec-0217 [30] acpi_ec_leave_burst_mo: ------->status fail
> 
> 2.6.13-rc{1,2} did not have this problem.

We reverted the ec burst mode changes.  I'll assume that 2.6.13-rc6 fixes
this up for you.  If not, or if problems remain, please let us know. 
Preferably via bugzilla.kernel.org, thanks.



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
