From: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Subject: Re: Latest acpica
Date: Thu, 08 Sep 2005 19:15:22 +0200
Message-ID: <432071AA.6020505@suse.de>
References: <43200F57.9040000@suse.de> <200509081859.57340.hugelmopf@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200509081859.57340.hugelmopf-S0/GAf8tV78@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Frank <hugelmopf-S0/GAf8tV78@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Frank wrote:
> I am having problems compiling this compiler on AMD64.
> It throws the following error message:
> 
> [compiler] $ make
> cc -Wall -O2 -Wstrict-prototypes -D_LINUX -DACPI_ASL_COMPILER -I../include    
> -c -o aslcompilerlex.o aslcompilerlex.c
> aslcompiler.l: In function `comment':
> aslcompiler.l:847: error: `yytext_ptr' undeclared (first use in this function)
> aslcompiler.l:847: error: (Each undeclared identifier is reported only once
> aslcompiler.l:847: error: for each function it appears in.)
> make: *** [aslcompilerlex.o] Error 1
> 
> This is not a new error though, I have had it for at least the 20050309 and 
> 20050513 release. It happens with GCC 3.3, 3.4 and 4.0... anybody an idea? It 
> can't be happening only to me, can it?
I had no problems compiling the code on x86_64.
Maybe you have to update lex/yacc packages?
> 
> Thanks,
> Frank

     Thomas


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
