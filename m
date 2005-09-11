From: ebiederm-aS9lmoZGLiVWk0Htik3J/w@public.gmane.org (Eric W. Biederman)
Subject: Re: reboot vs poweroff
Date: Sun, 11 Sep 2005 02:53:39 -0600
Message-ID: <m1psrghtnw.fsf@ebiederm.dsl.xmission.com>
References: <F7DC2337C7631D4386A2DF6E8FB22B30047B8DAF@hdsmsx401.amr.corp.intel.com>
	<m1d5ngk4xa.fsf@ebiederm.dsl.xmission.com>
	<Pine.SOC.4.61.0509111140550.9218@math.ut.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <Pine.SOC.4.61.0509111140550.9218-ptEonEWSGqKptlylMvRsHA@public.gmane.org> (Meelis Roos's
 message of "Sun, 11 Sep 2005 11:43:04 +0300 (EEST)")
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Meelis Roos <mroos-Y27EyoLml9s@public.gmane.org>
Cc: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Pierre Ossman <drzeus-list-p3sGCRWkH8CeZLLa646FqQ@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, ncunningham-3EexvZdKGZRWk0Htik3J/w@public.gmane.org, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Masoud Sharbiani <masouds-VSK0CvVmMoVQFI55V6+gNQ@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Meelis Roos <mroos-Y27EyoLml9s@public.gmane.org> writes:

>> OK hopefully this is my final version of this bug fix.
>
> I'm not in the position to test threse patches any more because the mainboard in
> question died last week when I installed some more RAM into it. Masoud Sharbiani
> <masouds-VSK0CvVmMoVQFI55V6+gNQ@public.gmane.org> added to CC: since he experienced the same problem.

Thanks for looking.

At this point I am less worried about fixing the bug.  Then I am
worried about the form of the bug fix.  (i.e. do weird compile
options break it).

But any testing or review is appreciated.

Eric



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
