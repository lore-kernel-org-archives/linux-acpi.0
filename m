From: Johan Vromans <jvromans-2pNSKKP3PSKEVqv0pETR8A@public.gmane.org>
Subject: Re: Centrino speedstep
Date: Thu, 30 Dec 2004 00:26:29 +0100
Message-ID: <m24qi48z4q.fsf@phoenix.squirrel.nl>
References: <m2zmzyw4e7.fsf@phoenix.squirrel.nl>
	<20041228212653.GA8436@dominikbrodowski.de>
	<m2vfalc53k.fsf@phoenix.squirrel.nl> <41D30842.4040204@paranoici.org>
	<20041229205905.GA12181@dominikbrodowski.de>
	<m2sm5o23ix.fsf@phoenix.squirrel.nl>
	<20041229214629.GA21054@dominikbrodowski.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20041229214629.GA21054-X3ehHDuj6sIIGcDfoQAp7BvVK+yQ3ZXh@public.gmane.org> (Dominik
 Brodowski's message of "Wed, 29 Dec 2004 22:46:29 +0100")
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

Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7BvVK+yQ3ZXh@public.gmane.org> writes:

> in the _PSS, first block, somewhere should be 1600. Change it to 1500.

I see two places. Second is a PPSS block with 5 entries, corresponding
to the CPU states. The first one contains a 0x640 (= 1600).
Right before it is a CPSS block, that seems to be a copy of the first
CPU state. I guess this has to be modified as well?

        Method(_PSS) {
            If(CLNM) {
                Return(CPSS)
            }
            Return(PPSS)
        }
        Name(CPSS, Package(0x1) {
            Package(0x6) {
==>             0x0640,
                0x5dc0,
                0xa,
                0xa,
                0x89,
                0x0,
            },
        })
        Name(PPSS, Package(0x5) {
            Package(0x6) {
==>             0x0640,
                0x5dc0,
                0xa,
                0xa,
                0x89,
                0x0,
            },
            ... 4 more for other states ...
       })

-- Johan


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
