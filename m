From: linas@austin.ibm.com (Linas Vepstas)
Subject: Re: [PATCH 2/5] Construct one fakephp slot per pci slot
Date: Tue, 13 Nov 2007 13:48:15 -0600
Message-ID: <20071113194815.GC8421@austin.ibm.com>
References: <20071113000853.GA13341@ldl.fc.hp.com> <20071113001336.GC13341@ldl.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1762177AbXKMTsa@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20071113001336.GC13341@ldl.fc.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Chiang <achiang@hp.com>
Cc: gregkh@suse.de, kristen.c.accardi@intel.com, lenb@kernel.org, matthew@wil.cx, rick.jones2@hp.com, linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz, pcihpd-discuss@lists.sourceforge.net, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Nov 12, 2007 at 05:13:36PM -0700, Alex Chiang wrote:
> +	slot->name = kmalloc(8, GFP_KERNEL);
> +	sprintf(slot->name, "fake%d", count++);

Please use snprintf to avoid buffer overruns!

--linas
