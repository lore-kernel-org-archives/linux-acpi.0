From: Michael Thonke <iogl64nx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Re: 2.6.13-rc3-mm3
Date: Fri, 05 Aug 2005 14:00:31 +0200
Message-ID: <42F354DF.2050402@googlemail.com>
References: <971FCB6690CD0E4898387DBF7552B90E023F8527@orsmsx403.amr.corp.intel.com>	<42EAC9DB.9010702@gmail.com> <20050804155513.727a3894.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050804155513.727a3894.akpm-3NddpPZAyC0@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
Cc: robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org



Hello Andrew,
> Andrew Morton wrote:
> Michael, I'm assuming that a) this problem remains in those -mm kernels
> which include git-acpi.patch and that b) the problems are not present in
> 2.6.13-rc5 or 2.6.13-rc6, yes?
>   
a.) I don't have any problems in 2.6.13-rc5-git[1-3] and 2.6.13-rc4-mm1 
they are working quite fantastic.
Good work :-)
> So I think we have a bug in git-acpi.patch?
>   
I reverted them and left them in..no problems with kernels I said above.
Again good work :-)
> If that's all correct then can you please test the next -mm (which will
> include git-acpi.patch - the most recent -mm did not) and if the bug's
> still there can you raise a bugzilla.kernel.org entry for it?
>   
I would, but the motherboard is dropped from my hardware test approval. 
Maybe I can get it back to test again
if it helps to solve some acpi issues.
> We seem to have a handful of bug reports against the -mm acpi patch.
>   
Well, I noticed that there are a lots of bugs and I'm willing to find 
search and reproduce them.

> Thanks.
I have to say thanks for the great help/feedback.

Greets and
Best regards

--
_Michael Thonke
IT-Systemintegrator /
System- and Softwareanalyist



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
