From: Paulo da Silva <pvmagacho78-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Subject: Re: OperationRegion outside scope
Date: Fri, 12 Nov 2004 09:01:38 -0800 (PST)
Message-ID: <20041112170138.35367.qmail@web41129.mail.yahoo.com>
References: <20041112153216.GF31422@poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20041112153216.GF31422-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


Hi,

  these solutions solves the errors for the
compilation. However, when using the iasl you will see
in the compiled file that the operation regions that
are outside any scope will have zero length. And this
causes different errors.
  I put two files on the web.
  1) http://cern.ch/paulo/before.log
     this is the message log that is produced by using
the default dsdt that comes with my bios.
  2) http://cern.ch/paulo/after.log
     this is the message log that is produce after I
introduce the changes needed for compiling the code.

  In the first one the errors come from the operation
regions that prevented me from compiling the code,
while the second file shows errors coming because the
iasl compiler puts size equal to zero for operation
regions that are outside a scope.

   I don't know if all operation regions should be put
inside a scope or this is a problem with the iasl
compiler.

Thank you,
Paulo da Silva

--- Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org> wrote:

> On Fri, Nov 12, 2004 at 02:47:54AM -0800, Paulo da
> Silva wrote:
> > Hello,
> > 
> > my DSDT has some operation regions defined outside
> a
> > scope and when I compile with iasl I see that the
> size
> > of the operation region is not considered and is
> set
> > to zero. Because of that I get lots of errors
> during
> > boot. One of the messages is shown below.
> > kernel:  exfldio-0143 [54] ex_setup_region       :
> > Field [CMD_] access width (1 bytes) too large for
> > region [MNVS] (length 0)
> > kernel:  exfldio-0155 [54] ex_setup_region       :
> > Field [CMD_] Base+Offset+Width FC0+0+1 is beyond
> end
> > of region [MNVS] (length 0)
> 
> I guess you forced the compilation of the DSDT,
> right?
> 
> > 
> > The original dsdt is at
> > http://cern.ch/paulo/dsdt.dsl.orig
> > 
> 
> You may try this patch which should allow you to
> recompile without
> errors:

> Bruno Ducrot
> 
> --  Which is worse:  ignorance or apathy?
> --  Don't know.  Don't care.
> 



		
__________________________________ 
Do you Yahoo!? 
Check out the new Yahoo! Front Page. 
www.yahoo.com 
 



-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
