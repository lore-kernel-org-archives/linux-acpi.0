From: jvromans-2pNSKKP3PSKEVqv0pETR8A@public.gmane.org (Johan Vromans)
Subject: Re: Centrino speedstep
Date: Fri, 31 Dec 2004 11:43:17 +0100
Message-ID: <16853.11589.510743.384997@phoenix.squirrel.nl>
References: <m2zmzyw4e7.fsf@phoenix.squirrel.nl>
	<20041228212653.GA8436@dominikbrodowski.de>
	<20041229181834.GA19199@poupinou.org>
	<41D42E88.5080800@mega.ist.utl.pt>
	<m2llbfk931.fsf@phoenix.squirrel.nl>
	<41D43A9F.5050507@mega.ist.utl.pt>
	<16852.15668.315630.700537@phoenix.squirrel.nl>
	<41D4AA9F.7080200@mega.ist.utl.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pedro Venda <pjlv-aHmAgkVUFT6Joy8PIJZ9VA@public.gmane.org>
Cc: Johan Vromans <jvromans-2pNSKKP3PSKEVqv0pETR8A@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

[Quoting Pedro Venda, on December 31 2004, 01:25, in "Re: Centrino speedst"]
> > Yes. Upon boot, I always get the message:
> > 
> >   speedstep-centrino: no table support for CPU model "Intel(R) Pentium(R) M processor 1.50GHz": 
> >   speedstep-centrino: try compiling with CONFIG_X86_SPEEDSTEP_CENTRINO_ACPI enable
> 
> I'm also using stock kernel 2.6.10 with stock acpi code but I have a different
> message:
> speedstep-centrino: invalid ACPI data

Hmm. You're using the standard 2.6.10 ACPI stuff, while I have applied
the acpi patch kit. Could that be the difference?

-- Johan


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
