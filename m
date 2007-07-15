From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: Re: ACPI: thinkpad-acpi: make the input event	mode
	the default
Date: Sun, 15 Jul 2007 19:08:01 -0300
Message-ID: <20070715220801.GK19066@khazad-dum.debian.net>
References: <11844223322928-git-send-email-hmh@hmh.eng.br>
	<11844223341511-git-send-email-hmh@hmh.eng.br>
	<20070714223315.GB25782@srcf.ucam.org>
	<20070715180529.GF14134@khazad-dum.debian.net>
	<20070715183823.GC3235@srcf.ucam.org>
	<20070715200948.GC19066@khazad-dum.debian.net>
	<20070715201346.GB5518@srcf.ucam.org>
	<20070715211421.GG19066@khazad-dum.debian.net>
	<20070715211953.GA6527@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20070715211953.GA6527-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Cc: ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Richard Hughes <hughsient-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sun, 15 Jul 2007, Matthew Garrett wrote:
> On Sun, Jul 15, 2007 at 06:14:21PM -0300, Henrique de Moraes Holschuh wrote:
> > On Sun, 15 Jul 2007, Matthew Garrett wrote:
> > > We already have in-kernel drivers that do this properly, so I'd suspect 
> > > that whoever told you that was wrong.
> > 
> > I got tired of being told one way or the other, already.
> > 
> > My position is simple, for now: I am keeping model-specific knowledge on the
> > driver to the bare minimum needed for correct driver operation.  But I will
> > add it anytime I fell it is needed to keep correct driver operation.
> 
> Right now, the hotkey functionality of the driver is not terribly useful 
> without (bleeding-edge) userspace. This is inconsistent with the 
> majority of input drivers which do something broadly sane in that 
> situation.

It works better with non-bleeding-edge userspace the way I did it, as far as
I know. So I'll need some explanations about what I should be doing
differently.

Here's my view on things:

Non-bleeding-edge userspace screws up volume control if I send events.  And
so does bleeding-edge userspace for that matter, AFAIK.

Non-bleeding-edge userspace screws up brightness control if I send events.
Bleeding-edge userspace needs to be told it exists, anyway, to make proper
use of it, and can be told to enable it on the driver while at it.

Non-bleeding-edge userspace that is not broken can remap keys already.
FN+F1 generating KEY_FN_F1 makes a lot more sense to someone which has a
blank FN+F1 key, than it generating "KEY_FOOBAR".

So exactly what should I be changing to make it more useful?  WHAT hot keys
do you want mapped by default, and to which key codes?  And forget the ones
that need passive handling, these are not mapped for a very different
reason.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
