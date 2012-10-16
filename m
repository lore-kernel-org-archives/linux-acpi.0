From: David Rientjes <rientjes@google.com>
Subject: Re: [PATCH] [resend] ACPI: Fix memory leak in acpi_bind_one()
 (fwd)
Date: Tue, 16 Oct 2012 12:14:16 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1210161214001.4770@chino.kir.corp.google.com>
References: <alpine.LNX.2.00.1210152049550.1038@swampdragon.chaosbits.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LNX.2.00.1210152049550.1038@swampdragon.chaosbits.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Jesper Juhl <jj@chaosbits.net>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, 15 Oct 2012, Jesper Juhl wrote:

> Memory is allocated with kzalloc() and assigned to
> 'physical_node'. Then 'physical_node->node_id' is initialized with a
> call to 'find_first_zero_bit()', if that results in a value greater
> than ACPI_MAX_PHYSICAL_NODE we'll end up jumping to the 'err:' label
> and there leave the function and let 'physical_node' go out of scope
> and leak the memory we allocated.
> This patch fixes the leak by simply freeing the unused/unneeded memory
> pointed to by 'physical_node' just before we jump to 'err:'.
> 
> Signed-off-by: Jesper Juhl <jj@chaosbits.net>

Acked-by: David Rientjes <rientjes@google.com>
