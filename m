From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v3 2/3] ACPI / OSL: Allow PCI to be disabled
Date: Tue, 11 Dec 2018 09:09:57 -0800
Message-ID: <20181211170957.GA335@infradead.org>
References: <20181210181315.5023-1-okaya@kernel.org>
 <20181210181315.5023-2-okaya@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181210181315.5023-2-okaya@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sinan Kaya <okaya@kernel.org>
Cc: linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, Dec 10, 2018 at 06:13:14PM +0000, Sinan Kaya wrote:
> Getting ready to allow PCI to be disabled with ACPI enabled. Stub
> out calls that depend on PCI.

I think you want to skip building at least all of hwpci.c if CONFIG_PCI
is disabled.  Or replace that whole stiking pile of crap with something
resembling C code..
