From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: About p4-clockmod breakage/removal
Date: Wed, 14 May 2008 13:56:18 +0100
Message-ID: <20080514125618.GA32422@srcf.ucam.org>
References: <48246C3E.7010608@ceibo.fiec.espol.edu.ec>
	<200805132048.00653.lenb@kernel.org>
	<20080514005636.GA21608@srcf.ucam.org>
	<1210764974.29724.181.camel@queen.suse.de>
	<20080514114215.GA31135@srcf.ucam.org>
	<1210769358.21269.21.camel@queen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-bounces+glkc-cpufreq=gmane.org@lists.linux.org.uk>
Content-Disposition: inline
In-Reply-To: <1210769358.21269.21.camel@queen.suse.de>
List-Unsubscribe: <http://lists.linux.org.uk/mailman/listinfo/cpufreq>,
	<mailto:cpufreq-request@lists.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.linux.org.uk/mailman/private/cpufreq>
List-Post: <mailto:cpufreq@lists.linux.org.uk>
List-Help: <mailto:cpufreq-request@lists.linux.org.uk?subject=help>
List-Subscribe: <http://lists.linux.org.uk/mailman/listinfo/cpufreq>,
	<mailto:cpufreq-request@lists.linux.org.uk?subject=subscribe>
Sender: cpufreq-bounces@lists.linux.org.uk
Errors-To: cpufreq-bounces+glkc-cpufreq=gmane.org+glkc-cpufreq=gmane.org@lists.linux.org.uk
To: Thomas Renninger <trenn@suse.de>
Cc: cpufreq@lists.linux.org.uk, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Wed, May 14, 2008 at 02:49:18PM +0200, Thomas Renninger wrote:

> You might find a hack to modify this, by reading P4 (this seem to sit in
> the CPU itself?) or chipset specs. But again, is it worth it for a P4
> where no power saving capabilities are present anyway?

If the alternative is thermal shutdown, sure. I'll take a look through 
the specs.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
