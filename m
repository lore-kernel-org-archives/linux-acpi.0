From: Tejun Heo <htejun@gmail.com>
Subject: Re: Disk spin down issue on shut down/suspend to disk
Date: Tue, 07 Aug 2007 23:37:47 +0900
Message-ID: <46B883BB.10909@gmail.com>
References: <fa.bsWpbo79BZgHoaIGhEMfTEBxs54@ifi.uio.no> <fa.mg6p0itaOQUo/t8deCaYpyqj6Nk@ifi.uio.no> <fa.RxWYL8z8KktgL8LGZ/cTB2nI1Yc@ifi.uio.no> <fa.AyyCtZ2yLjC5noHPHtmzn4ffhhE@ifi.uio.no> <fa.SuAjism+m0z0haqCRVjkc2S978o@ifi.uio.no> <fa.QgWcLG2hfRb92g4blN61qYfRjlQ@ifi.uio.no> <46B7AF53.1040307@shaw.ca> <46B8140E.3000509@gmail.com> <46B88173.3020302@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
In-Reply-To: <46B88173.3020302@shaw.ca>
Sender: linux-ide-owner@vger.kernel.org
To: Robert Hancock <hancockr@shaw.ca>
Cc: Michael Sedkowski <sedmich@gmail.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, linux-acpi@vger.kernel.org, Thomas Renninger <trenn@suse.de>
List-Id: linux-acpi@vger.kernel.org

Robert Hancock wrote:
> Tejun Heo wrote:
>> Yeah, that seems to be what's going on.  I don't think we have any other
>> choice than blacklisting those notebooks.  This is a mess.  How does the
>> other OS cope with this?
> 
> Quite possible that it gets a double spindown with these laptop/drive
> combinations as well. I don't think it's particularly harmful as long as
> there's no emergency unload..

I heard that spinning a harddrive back up while the platter is still
spinning from the previous spindown can have pretty bad affect on the
harddisk.  This is from a Samsung HDD service guy and I'm not sure how
credible it is at all.

Thanks.

-- 
tejun
