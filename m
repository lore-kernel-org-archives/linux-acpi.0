From: Eric Valette <eric.valette-GANU6spQydw@public.gmane.org>
Subject: Re: Radeon PM Support
Date: Wed, 04 Aug 2004 20:35:55 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <41112C8B.2030006@free.fr>
References: <1091139240.26511.9.camel@6-allhosts>        <20040730141028.GE21359@luna.mooo.com>        <20040730162756.4f300a5c@localhost>        <20040730190047.GH21359@luna.mooo.com>        <1091560208.24759.15.camel@6-allhosts>        <41103952.2030707@optonline.net>        <1091583216.2974.2.camel@localhost.localdomain>        <1091590835.2304.64.camel@dhcppc4>        <yzohdrjqu6p.fsf@localhost.localdomain>        <1091631174.2297.90.camel@dhcppc4>        <52654.199.172.169.15.1091641493.squirrel@webmail.localnet.com>        <4111217B.8000900@optonline.net> <62466.199.172.169.15.1091643791.squirrel@webmail.localnet.com>
Reply-To: eric.valette-GANU6spQydw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <62466.199.172.169.15.1091643791.squirrel-2RFepEojUI20LjuDPgauC1aTQe2KTcn/@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: count0-tC47gz4GrgtWk0Htik3J/w@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

count0-tC47gz4GrgtWk0Htik3J/w@public.gmane.org wrote:
>>count0-tC47gz4GrgtWk0Htik3J/w@public.gmane.org wrote:
>>
>>>This S3 resume POST patch has to go into the official ACPI/kernel
>>>source, just has to. POST'ing the video adapter on resume is
>>>absolutely fundamental. That some older non-Radeon cards can
>>>do without and we've gone this long without it is just amazing
>>>coincidence. This should go in right away, anything is better
>>>than nothing. -Huw
>>
>>Huh? acpi_sleep=s3_bios is in the mainline.
> 
> 
> It doesn't work, and it never has except in serendipitous
> circumstances. It happens at the wrong time, with interrupts
> in completely the wrong state. If it ever worked for anyone,
> it's a miracle that should not be regarded as a reason to
> perpetuate it. Let's get rid of it and replace it with the
> right solution - this more recent patch. -Huw

At least is works for me (radeon 7500, Ausus L3800C).

Note that I would be glad not to rely on the BIOS but I think your 
wording is a little bit strong...

-- eric




-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
