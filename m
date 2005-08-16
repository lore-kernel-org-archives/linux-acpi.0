From: Johan Vromans <jvromans-2pNSKKP3PSKEVqv0pETR8A@public.gmane.org>
Subject: Re: Centrino not scaling to lowest frequency
Date: Tue, 16 Aug 2005 13:53:00 +0200
Message-ID: <m2hddqqesj.fsf@phoenix.squirrel.nl>
References: <200508152344.11572.fexpop@onlinehome.de>
	<m2u0hqqni1.fsf@phoenix.squirrel.nl>
	<200508161128.20966.fexpop@onlinehome.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200508161128.20966.fexpop-53koH/AXb86i2/dY4+mD5w@public.gmane.org> (Felix Homann's
 message of "Tue, 16 Aug 2005 11:28:20 +0200")
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

Felix Homann <fexpop-53koH/AXb86i2/dY4+mD5w@public.gmane.org> writes:

> Where else might frequencies be defined in the DSDT?

My DSDT has

Scope(_PR_) {
    Processor(CPU0, 0, 0x1010, 0x6) {
        Name(_PCT, Package(0x2) { ... }
        Method(_PSS) {
            If(CLNM) {
                Return(CPSS)
            }
            Return(PPSS)
        }
        Name(CPSS, Package(0x1) {
            Package(0x6) {
                0x5dc,		// 1500 Mhz
                ...
            },
        })
        Name(PPSS, Package(0x5) {
            Package(0x6) {
                0x5dc,		// 1500 Mhz
                ...
            },
            Package(0x6) {
		0x04b0,		// 1200 Mhz 
                ...

... and so on ...

-- Johan



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
