From: Kristen Carlson Accardi <kristen.c.accardi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] ACPI: ibm-acpi: allow module to load
 when acpi notifiers can't be set
Date: Thu, 15 Mar 2007 12:37:32 -0700
Message-ID: <20070315123732.2ac478a3.kristen.c.accardi@intel.com>
References: <20070315071019.GA22613@tuatara.stupidest.org>
	<20070315175113.GA6596@khazad-dum.debian.net>
	<20070315191721.GB2556@tuatara.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20070315191721.GB2556-ADlBjwePHCC1xTEMbVT0AQFcV7zePqp5@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Chris Wedgwood <cw-LC2/xnR6T6k@public.gmane.org>
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, 15 Mar 2007 12:17:21 -0700
Chris Wedgwood <cw-LC2/xnR6T6k@public.gmane.org> wrote:

> On Thu, Mar 15, 2007 at 02:51:14PM -0300, Henrique de Moraes Holschuh wrote:
> 
> > This patch allows for ibm-acpi to coexist (with diminished
> > functionality) with other drivers like ACPI_BAY.
> 
> Given the ACP_IBM_BAY implementation is more complete (or seems to be,
> please comment if that isn't the case) we should probably actually
> make sure that is the *preferred* code used (on suitable hardware) at
> run time surely?

I haven't followed the ibm_acpi development lately, but when I first
wrote the bay driver, it had a couple features that ibm_acpi didn't have,
and then of course, is missing some it does have.  What used to be the
case is that if bay was inserted after the laptop was booted, the ibm_acpi
driver would not capture the events because it would only install it's 
notifier at driver load time on bay devices that existed.  The second
case is that if you are using the generic dock driver (which is more
funtional than the ibm_acpi dock feature), for certain ibm laptops such
as the X60, you need to have undock events sent to the bay device so that
it can alert user space to unmount cd's etc (since the bay is on the ultrabase).

> 
> That way distributions can build both options and on IBM/Lenovo
> hardware it will use the IBM ACPI code and otherwise will use the
> generic ACPI BAY code?

I think for now this is a good idea - the ibm_acpi solution should be
preferred over the generic bay driver till it is more fully developed.
I don't know how to ensure this is done wrt load order though.

> 
> Perhaps the IBM_ACPI_BAY code should go away and any missing
> functionality provided there should be merged into ACPI_BAY?
> 

I think this is a good idea.  It would certainly be less confusing for users.
too late for this release though, perhaps this can be targetted at 2.6.22/23?

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
