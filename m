From: Markus Gaugusch <markus-z+rTbpWsRgbk7+2FdBfRIA@public.gmane.org>
Subject: Re: AW: reading battery status and CPU time
Date: Thu, 10 Apr 2003 15:44:10 +0200 (CEST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.53.0304101541190.27207@dynast.gaugusch.at>
References: <B900970C7DD9474C972986EB3EC7C58F0D4096@andromeda.agcad.local>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <B900970C7DD9474C972986EB3EC7C58F0D4096-PWLG29+z7hEKeIAE67mlpo2P0GrZ+RbP@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Apr 10, Herbert Nachtnebel <Herbert.Nachtnebel-8zxNtbQCHXIjuwv8T7myQQ@public.gmane.org> wrote:
> > btw: Does anybody know how I could print out 1/100 sec accurate
> > timestamps via syslog/dmesg?
> Read out the time stamp counter of the cpu (Pentium and up, RDTSC
> instruction) and print it. This register is incremented with the clock
> rate of the cpu. Therefore the accuracy should be much better than 1/100
> sec.
Ok, but how should I do this while AML code is being executed?
Or do you mean in the function that prints the debug output (just came to
my mind ...).
Nevertheless, I don't know how to achive that (I know C/C++ but I haven't
done much inside the kernel and don't know the function names, etc.)
Could you give me a hint? Thanks.

Markus
PS: It seems my notebook has just died, so testing will have to wait until
it is repaired - does anybody know the beep code 1 long, two short on a
sony vaio fx405? :-(((((

-- 
__________________    /"\
Markus Gaugusch       \ /    ASCII Ribbon Campaign
markus-z+rTbpWsRgbk7+2FdBfRIA@public.gmane.org     X     Against HTML Mail
                      / \


-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
