From: Bernard Blackham <bernard-4vSAtV5O1nc0n/F98K4Iww@public.gmane.org>
Subject: Re: Re: what is the worst laptop atm?
Date: Mon, 3 Jan 2005 21:44:45 +0800
Message-ID: <20050103134445.GH4468@blackham.com.au>
References: <20041227165207.GB9606@poupinou.org> <41D06CA6.30607@mega.ist.utl.pt> <20041228103019.GD9606@poupinou.org> <m2is6mzaip.fsf@phoenix.squirrel.nl> <20050101173611.GB2630@elf.ucw.cz> <20050103133138.GO19199@poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20050103133138.GO19199-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
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

On Mon, Jan 03, 2005 at 02:31:38PM +0100, Bruno Ducrot wrote:
> > > Actually, I've been told that ACER is payed by Microsoft for not
> > > helping Linux support. Yes, it's hearsay but it sounded reliable to me
> > > at the time.
> > 
> > I do not think above is true. Acer wants to have their batteries
> > working in linux, they just do not want to hack their BIOSen.

Not wanting to add FUD, but mere fact here - I have an Acer
TravelMate 4052. Here is an excerpt from my original DSDT. Pay
careful attention to ECDY.

--snip--
Name(ECDY, 0x3)

[...]

Scope(\_SB_) {
    Device(PCI0) {
        Method(_INI) {
           If(LEqual(SCMP(\_OS_, "Microsoft Windows"), Zero)) {
               [...]
               Store(0x0, ECDY)
           }

    [... snip ...]

    Method(_BST) {
        Store("==Main Battery Status _BST==", Debug)
        If(LGreater(ECDY, 0x0)) {
            Decrement(ECDY)
            Notify(\_SB_.PCI0.LPC0.BAT1, 0x81)
        }
        If(LAnd(ECOK(), LEqual(ECDY, 0x0))) {
            [ ... main battery info function ... ]
--snip--

In non-ASL terms, ECDY is a counter that is initialised to 3. If the
OS starts with "Microsoft Windows", it is set to 0 instead. And the
DSDT will refuse to return the battery state the first n times,
where n is the value of ECDY.

This was quite an issue for me, as the daemon which hibernates my
laptop when the battery is low would hibernate the machine
immediately upon booting.

Is there a good reason why a DSDT should not return a battery status
the first 3 times to OS's other than Microsoft Windows? Maybe there
is, but fixing that "feature" hasn't broken anything yet for me. I'd
be interested to know if there might be a good reason though.

Full DSDT at http://dagobah.ucc.asn.au/things/tm4052.html if anybody
is interested.

Bernard.

-- 
 Bernard Blackham <bernard at blackham dot com dot au>


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
