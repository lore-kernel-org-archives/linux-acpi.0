From: Greg Sarjeant <greg-QNIYhHqVzB9kr2E5YSwMOQ@public.gmane.org>
Subject: Gateway 200x - trouble supplying ECDT table
Date: Mon, 22 Dec 2003 10:10:55 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031222101055.7d0c9c71.greg@morningdave.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hello,

   I know that this has been covered here before, but I have gotten stuck, so I was wondering if someone could give me a nudge in the right direction.

   I have a Gateway 200x. Apparently, as discussed here previously (http://sourceforge.net/mailarchive/message.php?msg_id=6514510), these machines do not provide an ECDT. I am getting some EmbeddedController errors in dmesg, and do not have battery, button, thermal or ac adapter support. Obviously, it would be nice to resolve this :)

   I followed the thread above, and noticed that there is a patch for the 2.4.23 kernel that allows you to supply an ECDT as a boot parameter. Sounds like just the thing. I have applied the patch and am sending what I believe to be the correct parameters to the kernel in my grub.conf, but it will not use the faked ECDT. I imagine that I am just doing something stupid, but I can't figure out what it is right now. I have tried a number of different ways of specifying these parameters, but none has worked so far. I've posted some files (DSDT, dmesg, grub.conf and the version of the patch that I applied) at http://www.morningdave.org/acpi/. If someone could look them over and let me know if anything jumps out as obviously wrong, I would really appreciate it. Right now, I'm hopeful that it is just a subtle difference in the syntax for lilo.conf and grub.conf that I am not catching. If you nee
 d any other information, please let me know.

   Also, if it wouldn't be too much trouble, could someone let me know how one determines the command and data ports that are used by the EmbeddedController? I am using the values that folks seemed to agree on in the previous thread for this machine (0x66 and 0x62, respectively). But my only real justification is that they were mentioned in that thread, and I see those values in the DSDT. I don't really understand how I could have identified them without someone who knows what he is doing providing them first.

   Thanks,
   Greg


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
