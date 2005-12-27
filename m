From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: C4 non-strangeness [was: C4 strangeness [was Re: [PATCH] i386
	No Idle HZ aka dynticks 051221]
Date: Tue, 27 Dec 2005 16:33:30 +0100
Message-ID: <20051227153330.GA32545@isilmar.linta.de>
References: <200512210310.51084.kernel@kolivas.org>
	<20051225171617.GA6929@thunk.org> <20051226025525.GA6697@thunk.org>
	<20051226203806.GC1974@elf.ucw.cz>
	<20051226225246.GA9915@thunk.org>
	<20051226232712.GH1974@elf.ucw.cz>
	<20051227140325.GA1620@elf.ucw.cz>
	<20051227142238.GA1696@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ck-bounces@vds.kolivas.org>
Content-Disposition: inline
In-Reply-To: <20051227142238.GA1696@elf.ucw.cz>
List-Unsubscribe: <http://bhhdoa.org.au/mailman/listinfo/ck>,
	<mailto:ck-request@vds.kolivas.org?subject=unsubscribe>
List-Archive: <http://bhhdoa.org.au/pipermail/ck>
List-Post: <mailto:ck@vds.kolivas.org>
List-Help: <mailto:ck-request@vds.kolivas.org?subject=help>
List-Subscribe: <http://bhhdoa.org.au/mailman/listinfo/ck>,
	<mailto:ck-request@vds.kolivas.org?subject=subscribe>
Sender: ck-bounces@vds.kolivas.org
Errors-To: ck-bounces@vds.kolivas.org
To: Pavel Machek <pavel@ucw.cz>
Cc: vatsa@in.ibm.com, Theodore Ts'o <tytso@mit.edu>, Zwane Mwaikambo <zwane@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, Daniel Petrini <d.pensator@gmail.com>, linux kernel mailing list <linux-kernel@vger.kernel.org>, ck list <ck@vds.kolivas.org>, Adam Belay <abelay@novell.com>, ACPI mailing list <acpi-devel@lists.sourceforge.net>, ipw2100-admin@linux.intel.com
List-Id: linux-acpi@vger.kernel.org

Hi,

On Tue, Dec 27, 2005 at 03:22:38PM +0100, Pavel Machek wrote:
> So... I guess I found out what is going on.
> 
> When power is unplugged, X32 adds C4 state. When power is plugged, X32
> removes C4 state (behaviour Ted seen). When I load ipw2200, this
> behaviour stops, and I see everything up-to C4. Strange. I remember
> ipw had some problems with C3 and C4, perhaps this is related?

Nothing strange at all. The C-States are exported by the BIOS to the OS
using the _CST method/object/whatever. This can change on runtime. When the
BIOS recognizes it is on battery power, the _CST contains the C4 state, if
it is on AC power, the _CST doesn't contain it. The ACPI code follows what
it is told by the BIOS, for it has no chance to know about this additional
C-State if on AC power, and it wouldn't be wise to second-guess the BIOS.

Ipw does limit the max_cstate setting dynamically if it recognizes problems;
however I haven't seen _any_ such things lately on my own system. Might be
related to dyntick being _enabled_, though ;-)

	Dominik
