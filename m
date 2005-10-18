From: Mattia Dongili <malattia-k2GhghHVRtY@public.gmane.org>
Subject: Re: Latest acpica
Date: Tue, 18 Oct 2005 22:14:07 +0200
Message-ID: <20051018201407.GB3945@inferi.kami.home>
References: <971FCB6690CD0E4898387DBF7552B90E02AA4005@orsmsx403.amr.corp.intel.com> <c0a09e5c0510121037l3be5774bj3ec5e0d50449c69f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <c0a09e5c0510121037l3be5774bj3ec5e0d50449c69f-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Andrew Grover <andy.grover-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, Oct 12, 2005 at 10:37:59AM -0700, Andrew Grover wrote:
> I am using GNU flex 2.5.31. I was able to get it to build (on x86_64 even)
> with the attached patch. I have also attached the warnings, in case those
> are of interest.

I tried building my DSDT with a patched iasl built with the latest flex
available in debian (2.5.31) but it seems the -l flag is doing more bad
than good. I get a bunch of (meaningless) errors:

DSDT.dsl    34:     Scope (\_GPE)
Error    1094 -                ^ syntax error, unexpected PARSEOP_NAMESEG, expecting ')'

DSDT.dsl    38:             Notify (\_SB.PCI0.USB1, 0x02)
Error    1094 -                        ^ syntax error, unexpected PARSEOP_NAMESEG, expecting ','

DSDT.dsl    38:             Notify (\_SB.PCI0.USB1, 0x02)
Error    1094 -                         ^ Invalid character (0x2E), expecting ASL keyword or name

DSDT.dsl    43:             Notify (\_SB.PCI0.USB2, 0x02)
Error    1094 -                        ^ syntax error, unexpected PARSEOP_NAMESEG, expecting ','
...
...
ASL Input:  DSDT.dsl - 3597 lines, 124899 bytes, 20 keywords
Compilation complete. 15 Errors, 0 Warnings, 0 Remarks, 2 Optimizations

while building with flex-old I only get:

DSDT.dsl  1347:                     Field (ECR, AnyAcc, Lock, Preserve)
Error    1073 -                              ^ Host Operation Region requires ByteAcc access

ASL Input:  DSDT.dsl - 3896 lines, 131852 bytes, 1959 keywords
Compilation complete. 1 Errors, 0 Warnings, 0 Remarks, 388 Optimizations

So I'll probably simply build-depend on flex-old by now and I'll try to learn
more of flex soon :)

-- 
mattia
:wq!


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
