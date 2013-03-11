From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [Xen-devel] [PATCH] Xen/ACPI: support sleep state
 entering on hardware reduced systems
Date: Mon, 11 Mar 2013 09:53:22 -0400
Message-ID: <20130311135322.GA25036@phenom.dumpdata.com>
References: <513DB68E02000078000C4864@nat28.tlf.novell.com>
	<20130311132127.GH23018@phenom.dumpdata.com>
	<513DEAF102000078000C496E@nat28.tlf.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <tboot-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <513DEAF102000078000C496E@nat28.tlf.novell.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/tboot-devel>,
	<mailto:tboot-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=tboot-devel>
List-Post: <mailto:tboot-devel@lists.sourceforge.net>
List-Help: <mailto:tboot-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/tboot-devel>,
	<mailto:tboot-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: tboot-devel-bounces@lists.sourceforge.net
To: Jan Beulich <JBeulich@suse.com>
Cc: xen-devel <xen-devel@lists.xen.org>, rjw@sisk.pl, linux-acpi@vger.kernel.org, "tboot-devel@lists.sourceforge.net" <tboot-devel@lists.sourceforge.net>, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, Mar 11, 2013 at 01:32:17PM +0000, Jan Beulich wrote:
> >>> On 11.03.13 at 14:21, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com> wrote:
> > Could the commit should also mention what version of the Xen hypervisor
> > supports this new flag and takes action on it?
> 
> Do you really think this is needed? I generally try to stay away
> from doing such, since backports can easily invalidate such
> statements.

Perhaps just mention the title of the patch in the Xen tree?

> 
> > Besides that little nit-pick it looks OK to me. Are there any changes
> > neccessary on the IA64 or ARM side for this?
> 
> Xen on IA64 is dead, so I don't see any need for further action

You are touching generic ACPI code. My question was in terms of
the Linux ACPI IA64 code.

> there. And I don't think ARM has any ACPI enablement so far (on
> the Xen side at least).

And also on the Linux side by just doing a quick grep. Surely
that will change at some point.

> 
> Jan
> 
> 
> _______________________________________________
> Xen-devel mailing list
> Xen-devel@lists.xen.org
> http://lists.xen.org/xen-devel
> 

------------------------------------------------------------------------------
Symantec Endpoint Protection 12 positioned as A LEADER in The Forrester  
Wave(TM): Endpoint Security, Q1 2013 and "remains a good choice" in the  
endpoint security space. For insight on selecting the right partner to 
tackle endpoint security challenges, access the full report. 
http://p.sf.net/sfu/symantec-dev2dev
