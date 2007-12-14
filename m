From: Tejun Heo <htejun@gmail.com>
Subject: Re: ATA ACPI needs "Mr interpreter, would you please shut up?" flag
Date: Fri, 14 Dec 2007 15:28:47 +0900
Message-ID: <4762229F.8020900@gmail.com>
References: <47620E5E.5020001@gmail.com> <4762129F.6060209@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
In-Reply-To: <4762129F.6060209@shaw.ca>
Sender: linux-ide-owner@vger.kernel.org
To: Robert Hancock <hancockr@shaw.ca>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, linux-acpi@vger.kernel.org, Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Randy Dunlap <randy.dunlap@oracle.com>
List-Id: linux-acpi@vger.kernel.org

Robert Hancock wrote:
>> Problem is that _GTM implementation on certain BIOSen crap themselves if
>> invoked on empty channels.  However, as written above, because initial
>> _GTM caching is done before any actual operation is performed on the
>> port, libata can't determine whether the port is occupied or not when
>> trying to cache _GTM result.  Unfortunately, VIA PATA is on both
>> categories - it needs _GTM caching but can't cope with _GTM invocation
>> on empty ports.  Yay!
> 
> I seem to have lost the thread/bug report where we decided that one
> board always choked on an empty channel. Maybe it's not that and it's
> just another case of the same issue where our resetting default timing
> values on the controller before calling _GTM would choke the _GTM method?

Could be.  Hans' machine on bug 9320 is the affected one (PATA on via
CN700).  I asked him to test the final version.  If it indeed is caused
by the same problem, there won't be evaluation failures.

Anyways, table-based implementations like the NVidia and VIA ones are
bound to fail on certain conditions.  libata reconfigures transfer mode
aggressively under certain failure conditions and _GTM invocation will
fail if the port is in a mode which is not on ACPI's mode table (which
doesn't seem to be too comprehensive anyway).  So, there's always
possibility of _GTM failure for those boards, which in turn can fail
_GTF evaluation.

As _GTM, _STM and _GTF aren't strictly necessary for operation anyway, I
think it's better to print ATA ACPI evaluation failure messages using
KERN_DEBUG.

Thanks.

-- 
tejun
