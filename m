From: Shawn Starr <shawn.starr-bJEeYj9oJeDQT0dZR+AlfA@public.gmane.org>
Subject: Re: Fwd: [2.6.12-rc1][ACPI][suspend] /proc/acpi/sleep vs /sys/power/state issue - 'standby' on a laptop
Date: Thu, 31 Mar 2005 23:32:26 -0500
Message-ID: <200503312332.27013.shawn.starr@rogers.com>
References: <200503280302.57640.shawn.starr@rogers.com> <200503300142.54497.shawn.starr@rogers.com> <200503301508.08721.luming.yu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="gb18030"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200503301508.08721.luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Content-Disposition: inline
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

To further, is /proc/acpi deprecated? or is some of the duplicate 
functionality such as suspending going to be removed?

If so, the patch won't be worth writing if its being removed :)

Shawn.

On March 30, 2005 02:08, you wrote:
> Good question. could you write a patch for what you said.
>
> On Wednesday 30 March 2005 14:42, Shawn Starr wrote:
> > Right, but then why is it trying to do 'something' even if there is no S1
> > support? :)
> >
> > it should do the same thing if i echo 1 to /sys/power/state. which is
> > nothing at all.
> >
> > Shawn.
> >
> > On March 30, 2005 01:37, Yu, Luming wrote:
> > > On Monday 28 March 2005 16:02, Shawn Starr wrote:
> > > > However, trying echo "1" to /proc/acpi/sleep the system attempts to
> > > > (standby) and aborts:
> > > >
> > > > [4295945.236000] PM: Preparing system for suspend
> > > > [4295946.270000] Stopping tasks:
> > > > =====================================================================
> > > >== == == == [4295946.370000] Restarting tasks... done
> > > >
> > > > We get no reason as to why it quickly aborts.
> > >
> > > echo 1 to acpi/sleep means S1 called standby.
> > > echo 3 to acpi/sleep means S3 called STR: sleep to ram
> > > echo 4 to acpi/sleep means S4 called STD: sleep to disk
> > >
> > > If you system just support S0, S3, S4, S5,
> > > NO S1 support.


-------------------------------------------------------
This SF.net email is sponsored by Demarc:
A global provider of Threat Management Solutions.
Download our HomeAdmin security software for free today!
http://www.demarc.com/Info/Sentarus/hamr30
