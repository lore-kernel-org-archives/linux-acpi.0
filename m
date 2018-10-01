From: Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH RFC] mm/memory_hotplug: Introduce memory block types
Date: Mon, 1 Oct 2018 10:40:38 +0200
Message-ID: <20181001084038.GD18290@dhcp22.suse.cz>
References: <20180928150357.12942-1-david@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
In-Reply-To: <20180928150357.12942-1-david@redhat.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: David Hildenbrand <david@redhat.com>
Cc: Kate Stewart <kstewart@linuxfoundation.org>, Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Balbir Singh <bsingharora@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-mm@kvack.org, Pavel Tatashin <pavel.tatashin@microsoft.com>, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, Rashmica Gupta <rashmica.g@gmail.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, linux-s390@vger.kernel.org, Michael Neuling <mikey@neuling.org>, Stephen Hemminger <sthemmin@microsoft.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Michael Ellerman <mpe@ellerman.id.au>, linux-acpi@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, xen-devel@lists.xenproject.org, Rob Herring <robh@kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Fri 28-09-18 17:03:57, David Hildenbrand wrote:
[...]

I haven't read the patch itself but I just wanted to note one thing
about this part

> For paravirtualized devices it is relevant that memory is onlined as
> quickly as possible after adding - and that it is added to the NORMAL
> zone. Otherwise, it could happen that too much memory in a row is added
> (but not onlined), resulting in out-of-memory conditions due to the
> additional memory for "struct pages" and friends. MOVABLE zone as well
> as delays might be very problematic and lead to crashes (e.g. zone
> imbalance).

I have proposed (but haven't finished this due to other stuff) a
solution for this. Newly added memory can host memmaps itself and then
you do not have the problem in the first place. For vmemmap it would
have an advantage that you do not really have to beg for 2MB pages to
back the whole section but you would get it for free because the initial
part of the section is by definition properly aligned and unused.

I yet have to think about the whole proposal but I am missing the most
important part. _Who_ is going to use the new exported information and
for what purpose. You said that distributions have hard time to
distinguish different types of onlinining policies but isn't this
something that is inherently usecase specific?
-- 
Michal Hocko
SUSE Labs
