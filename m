From: sjb <ottaky-XuTx12Z7TonQT0dZR+AlfA@public.gmane.org>
Subject: Re: best acpi solution
Date: Wed, 21 May 2003 15:56:57 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3ECBA1C9.70201@ottaky.com>
References: <3ECB3CE2.5000400@ottaky.com> <01db01c31f90$84ae6840$3746028e@bio.dfo.ca> <3ECB8ADF.5020108@ottaky.com> <024c01c31f9f$ac733b80$3746028e@bio.dfo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <024c01c31f9f$ac733b80$3746028e-dP0OE4Ef7fWw5LPnMra/2Q@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Derek Broughton <dbroughton-F3m4/jXepmf3fQ9qLvQP4Q@public.gmane.org>
Cc: ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Derek Broughton wrote:

> It wasn't apparent that you needed/wanted to do that.

Sorry - it was unclear.

> If you have to recompile, I'd apply the acpi patch to the current kernel source
> (NOT 2.4.20 - iirc, it's 2.4.21) and copy the config file that corresponds to
> your working kernel image (it's in the same directory as your kernel - usually
> in /boot/config*)

I've asked the guy who made the working to send me the config .. if he 
still has it.

> The "DSDT in initrd" patch can't do anything for you - it's for fixing DSDTs,
> and yours apparently doesn't need fixing.

My DSDT does contain errors and, thanks to others on here, I should now 
have a fixed version - although, as I say, it was working previously so 
the faults are presumably minor or at least not major.

sjb



-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
