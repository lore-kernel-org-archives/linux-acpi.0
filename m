From: Johan Vromans <jvromans-2pNSKKP3PSKEVqv0pETR8A@public.gmane.org>
Subject: Re: what is the worst laptop atm?
Date: Tue, 04 Jan 2005 11:28:25 +0100
Message-ID: <m2y8f9qyie.fsf@phoenix.squirrel.nl>
References: <20041227165207.GB9606@poupinou.org>
	<41D06CA6.30607@mega.ist.utl.pt> <20041228103019.GD9606@poupinou.org>
	<m2is6mzaip.fsf@phoenix.squirrel.nl>
	<20050101173611.GB2630@elf.ucw.cz>
	<20050103133138.GO19199@poupinou.org>
	<20050103134445.GH4468@blackham.com.au>
	<20050103145517.GR19199@poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050103145517.GR19199-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org> (Bruno Ducrot's message
 of "Mon, 3 Jan 2005 15:55:17 +0100")
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

Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org> writes:

> This is a well known workaround for Microsoft Windows NT 4.0.

My DSDT (TravelMate4001WLMi) has:

    Device(PCI0) {
        Name(MYOS, 0x2)
        Method(_INI) {
            Store(0x1, \_SB_.D1SJ)
            Store(0x2, MYOS)
            If(LEqual(SizeOf(\_OS_), 0x14)) {
                Store(0x1, MYOS)
                Store(0x07d0, OSYS)
                Store(0x1, \_SB_.W2KF)
                If(CondRefOf(_OSI, Local0)) {
==>                    If(\_OSI("Windows 2001")) {
                        Store(0x3, MYOS)
                        Store(0x07d1, OSYS)
                        Store(0x3, \_SB_.W2KF)
                    }
                }
            }

Also a known workaround?

-- Johan


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
