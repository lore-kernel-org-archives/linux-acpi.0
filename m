From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: what about the sony_acpi driver?
Date: Thu, 9 Jun 2005 15:03:21 +0800
Message-ID: <20050609070321.GB8009@linux.sh.intel.com>
References: <20050606110952.GA9447@message-id.gmane0305.slipkontur.de> <20050606132911.GA4633@linux.sh.intel.com> <20050606151235.GA28528@message-id.s3e.de> <20050606152829.GA5067@linux.sh.intel.com> <1118073314.6648.189.camel@tyrosine> <20050606161931.GC5067@linux.sh.intel.com> <20050607140838.GM8899@poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20050607140838.GM8899-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Cc: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On 2005.06.07 16:08:38 +0200, Bruno Ducrot wrote:
> On Tue, Jun 07, 2005 at 12:19:31AM +0800, Yu, Luming wrote:
> > On 2005.06.06 16:55:14 +0100, Matthew Garrett wrote:
> > > On Mon, 2005-06-06 at 23:28 +0800, Yu, Luming wrote:
> > > 
> > > > Believe me, generic-hotkey-driver and acpi-video-driver can handle these, if this is a acpi system.
> > > 
> > > A fairly large number of machines seem to have brightness control
> > > methods that aren't exposed via the acpi video device standard. Can
> > > these still be dealt with?
> > If they are ACPI system, I suppose they will rely on ASL method to handle video stuff. Then, I think generic-hotkey-driver can accommodate the quirks.
> > Please give me some example to prove I'm wrong. (The example should come from ACPI system.) 
> 
> On toshiba 3000 (and actually a lot of Compal laptops) LCD brightness is
> handled via a register in the EC space (sometimes the node is called BLVL,
> is at 0xb9, first 4 bits).
> 
> No ACPI methods (under, say, a video device) handle it, therefore it
> is necessary to read/write to it directly in order to control brightness
> as its done with the omke kernel module.

Thanks for this info. If there don't have AML-methods and GPEs related to hotkey features on a specific box, then
I think generic-hotkey-driver cannot help.

> 
> -- 
> Bruno Ducrot
> 


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
