From: Rajesh Shah <rajesh.shah-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [Fwd: ACPI State of art related question.]
Date: Fri, 21 May 2004 10:41:39 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040521104139.A16408@unix-os.sc.intel.com>
References: <40AAFA8B.7090704@Ext.Bull.Net> <1085111121.12354.558.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1085111121.12354.558.camel-D2Zvc0uNKG8@public.gmane.org>; from len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org on Thu, May 20, 2004 at 11:45:22PM -0400
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Francois Wellenreiter <Francois.Wellenreiter-vSCF+xk4DSocNi+XZuJMfw@public.gmane.org>, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, May 20, 2004 at 11:45:22PM -0400, Len Brown wrote:
> On Wed, 2004-05-19 at 02:11, Francois Wellenreiter wrote:
> 
> > I'm interested in the "Module Device" feature (cf spec
> > rev 2.0 chapter 10.11), is it taken into account actually ?
> 
> ACPI0004 -- Nope, not that I'm aware of, at least not yet.
> 
We are working on supporting ACPI based hot-plug of CPU, 
memory and host/P2P bridges. These resources could be
reported in an ACPI0004 or PNP0A05 container, so we are
working on a driver for these objects.  Some of this code 
is already available (see 
http://sourceforge.net/projects/lhns).  I didn't see the 
original post, so I don't know what your interest in the 
ACPI0004 container object is. 

Rajesh



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
