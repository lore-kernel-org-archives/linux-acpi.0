From: Ducrot Bruno <ducrot@poupinou.org>
Subject: Re: [PATCH 2.6] update passive cooling algorithm
Date: Mon, 12 Jan 2004 16:46:11 +0100
Sender: cpufreq-bounces@www.linux.org.uk
Message-ID: <20040112154611.GH14031@poupinou.org>
References: <20040111211255.GA31105@dominikbrodowski.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <cpufreq-bounces@www.linux.org.uk>
Content-Disposition: inline
In-Reply-To: <20040111211255.GA31105@dominikbrodowski.de>
List-Unsubscribe: <http://www.linux.org.uk/mailman/listinfo/cpufreq>,
	<mailto:cpufreq-request@www.linux.org.uk?subject=unsubscribe>
List-Archive: <http://www.linux.org.uk/mailman/private/cpufreq>
List-Post: <mailto:cpufreq@www.linux.org.uk>
List-Help: <mailto:cpufreq-request@www.linux.org.uk?subject=help>
List-Subscribe: <http://www.linux.org.uk/mailman/listinfo/cpufreq>,
	<mailto:cpufreq-request@www.linux.org.uk?subject=subscribe>
Errors-To: cpufreq-bounces@www.linux.org.uk
To: len.brown@intel.com, acpi-devel@lists.sourceforge.net, cpufreq@www.linux.org.uk
List-Id: linux-acpi@vger.kernel.org

On Sun, Jan 11, 2004 at 10:12:55PM +0100, Dominik Brodowski wrote:
> [Len, could you test and verify this patch, and push it to Linus, please?]
> 
> The current algorithm used by Linux ACPI for passive thermal management has
> two shortcomings:

...

> +/* If a passive cooling situation is detected, primarily CPUfreq is used, as it
> + * offers (in most cases) voltage scaling in addition to frequency scaling, and
> + * thus a cubic (instead of linear) reduction of energy. Also, we allow for
> + * _any_ cpufreq driver and not only the acpi-cpufreq driver.
> + */

Just a stupid question:

What is best if processor heat issues (apart turning on the fan)?

Reducing voltage of the processor, but still allowing it to run execution
at 100% (which is the case if the processor is heating), or reduce
amount of time allowed for the processor to execute?

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.
