From: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
Subject: Re: [GIT PATCH] ACPI for 2.6.14
Date: Thu, 8 Sep 2005 01:22:19 -0700
Message-ID: <20050908012219.6b5431b7.akpm@osdl.org>
References: <F7DC2337C7631D4386A2DF6E8FB22B30048B3F04@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <F7DC2337C7631D4386A2DF6E8FB22B30048B3F04-N2PTB0HCzHKkrb+BlOpmy7fspsVTdybXVpNB7YpNyf8@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: torvalds-3NddpPZAyC0@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

"Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
>
> I saw lots of transient battery issues from 2.6.13-rc3
>  until 2.6.13-rc6, but the ones I followed went away
>  as of 2.6.13 final.  Do you have your eye on others
>  besides 4980?

Not specifically, but then ACPI bugs are the one sort which I don't track. 
a) because there are so many and b) because the ACPI team use bugzilla
well.

Sticking "battery" into the bugzilla Summary field turns up a few. 
<vague>There seem to have been four or five reports in recent weeks.


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
