From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 2/6] ACPI / Battery: Change 16-bit signed
 negative battery current into correct value
Date: Wed, 29 Jun 2011 08:11:47 -0700
Message-ID: <20110629151147.GC18023@kroah.com>
References: <1309335765-26475-1-git-send-email-tianyu.lan@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <stable-bounces@linux.kernel.org>
Content-Disposition: inline
In-Reply-To: <1309335765-26475-1-git-send-email-tianyu.lan@intel.com>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/stable>,
	<mailto:stable-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/mailman/private/stable/>
List-Post: <mailto:stable@linux.kernel.org>
List-Help: <mailto:stable-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/stable>,
	<mailto:stable-request@linux.kernel.org?subject=subscribe>
Sender: stable-bounces@linux.kernel.org
Errors-To: stable-bounces@linux.kernel.org
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: linux-acpi@vger.kernel.org, rui.zhang@intel.com, stable@kernel.org, lenb@kernel.org
List-Id: linux-acpi@vger.kernel.org

On Wed, Jun 29, 2011 at 04:22:45PM +0800, Lan Tianyu wrote:
> This patch is for some machine which report the battery current
> as a 16-bit signed negative when it is charging. This is caused
> by DSDT bug. The commit bc76f90b8a5cf4aceedf210d08d5e8292f820cec
> has resolved the problem for Acer laptops. But some other machines
> also have such problem.
> 
>     https://bugzilla.kernel.org/show_bug.cgi?id=33722
> 
> Since it is improssible that the current is above 32A on laptops
> whether on AC or on battery, this patch is to check the current and
>  take its absolute value as current and producing a message when it
> is negative in s16.
> 
> Remove Acer quirk, as this workaround handles Acer too.
> 
> Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
> ---

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read Documentation/stable_kernel_rules.txt
for how to do this properly.

</formletter>

Same goes for the other patches in this series that you sent to
stable@kernel.org as well, please redo them.

_______________________________________________
stable mailing list
stable@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/stable
