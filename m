From: Michael Guntsche <mike-Z92qn3yYq0hWk0Htik3J/w@public.gmane.org>
Subject: Re: High pitched sound + OOPS with acpi/processor on DELL inspiron 8600
Date: Mon, 5 Jul 2004 14:34:17 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <A20E2C1A-CE7F-11D8-A294-000D93ADD12E@it-loops.com>
References: <20040705114836.GB20824@infinite.fsw.leidenuniv.nl>
Mime-Version: 1.0 (Apple Message framework v618)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040705114836.GB20824-bIuJOMs36amLXAJsILr3Yb0tsLj872yO8/qWW+O4k6E@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-TtF/mJH4Jtrk1uMJSBkQmQ@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


On Jul 5, 2004, at 13:48, Renald Buter wrote:

> On Mon, Jul 05, 2004 at 07:12:47PM +0800, Li, Shaohua wrote:
>> There is a patch in http://bugme.osdl.org/show_bug.cgi?id=1716, it
>> should fix your problem. Please try.
>>
>> Thanks,
>> Shaohua
>
> Thanks I will try tonight!
>
> But that should *only* fix the OOPS, doesn't it? The whining sound
> should still be there...
>

Try changing the HZ in linux/include/asm-i386/param.h from 1000 to 100.
This fixed the problem for me and I didn't experience any side effects.
NB: You should recompile all your external modules too , since some of 
em might not like the change without recompiling.

/Michael



-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
