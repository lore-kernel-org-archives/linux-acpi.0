From: Sinan Kaya <okaya@kernel.org>
Subject: Re: [PATCH v3 2/3] ACPI / OSL: Allow PCI to be disabled
Date: Tue, 11 Dec 2018 12:37:03 -0500
Message-ID: <342c5dd9-cb3d-d714-c87f-814a942cf395@kernel.org>
References: <20181210181315.5023-1-okaya@kernel.org>
 <20181210181315.5023-2-okaya@kernel.org> <20181211170957.GA335@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181211170957.GA335@infradead.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On 12/11/2018 12:09 PM, Christoph Hellwig wrote:
> On Mon, Dec 10, 2018 at 06:13:14PM +0000, Sinan Kaya wrote:
>> Getting ready to allow PCI to be disabled with ACPI enabled. Stub
>> out calls that depend on PCI.
> 
> I think you want to skip building at least all of hwpci.c if CONFIG_PCI
> is disabled.  Or replace that whole stiking pile of crap with something
> resembling C code..
> 

I can give it a try but I'm under the impression that we don't touch
ACPICA code in general.

Feel free to correct me.
