From: James Marca <jmarca-gxN29gZi1SnrmNeUD2Wsk/Z8FUJU4vz8@public.gmane.org>
Subject: kernel 2.5.66 on Sony PCG-FX210 hangs on boot
Date: Wed, 9 Apr 2003 10:29:03 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030409172903.GA1639@krypton.its.uci.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
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

Hi
I am running the 2.4 series kernels with the ACPI patches with no
problems.  With 2.5.65 and 2.5.66 I decided to try out the beta
kernels.  Both with and without the ACPI patch, these kernels fail to
boot on my laptop --- Sony PCG-FX210.

It is hard to report exactly what is happening.  The initial messages
scroll by fine---decompressing the kernel, etc., and then I see a
message about ACPI and then I get lots and lots of scrolling numbers
in angle brackets.  (Control S won't freeze the screen)  I am not 100
percent sure it is ACPI that is freaking out my computer, but after
trying the kernel many times last night, I am certain the last legible
message contained ACPI in the text before the rapid number scrolling
started.  

I have used user-mode linux (UML) before, and so when I get time I can
try to run the kernel in a protected area and grab a screenshot of the
initial error messages.  But last time this sort of thing happened,
there was a nocorruption patch to fix things.  Am I missing a patch?
Any other advice on how to collect bug reports or where the problem
might lie?

Please respond to the list, not to me personally.  

Thanks,
James





-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
