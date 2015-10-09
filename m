From: Dustin Byford <dustin@cumulusnetworks.com>
Subject: Re: [RFC v2 1/1] i2c: acpi: scan ACPI enumerated I2C mux channels
Date: Fri, 9 Oct 2015 14:50:16 -0700
Message-ID: <20151009215016.GA11590@cumulusnetworks.com>
References: <1439580693-5538-1-git-send-email-dustin@cumulusnetworks.com>
 <1439580693-5538-2-git-send-email-dustin@cumulusnetworks.com>
 <20151009214241.GC1481@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151009214241.GC1481@katana>
Sender: linux-i2c-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, rjw@rjwysocki.net, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Hi Wolfram,

On Fri Oct 09 22:42, Wolfram Sang wrote:
> On Fri, Aug 14, 2015 at 12:31:33PM -0700, Dustin Byford wrote:
> > 
> > Set an ACPI companion for I2C mux channels enumerated through ACPI and
> > ensure they are scanned for devices.
> > 
> > Signed-off-by: Dustin Byford <dustin@cumulusnetworks.com>
> 
> Mika, is this one okay with you?

I'm working on a revision that incorporates Mika's suggested patch I
think you'll want to wait just a bit for that.

Thanks,

		--Dustin
