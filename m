From: Len Brown <lenb@kernel.org>
Subject: Re: 2.6.20rc5 k8/acpi regression ( 2.6.17.13 works fine ).
Date: Wed, 24 Jan 2007 23:50:45 -0500
Message-ID: <200701242350.45276.lenb@kernel.org>
References: <200701242346.44673.pluto@agmk.net>
	<20070124225238.GT17836@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <cpufreq-bounces+glkc-cpufreq=m.gmane.org@lists.linux.org.uk>
In-Reply-To: <20070124225238.GT17836@stusta.de>
Content-Disposition: inline
List-Unsubscribe: <http://lists.linux.org.uk/mailman/listinfo/cpufreq>,
	<mailto:cpufreq-request@lists.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.linux.org.uk/mailman/private/cpufreq>
List-Post: <mailto:cpufreq@lists.linux.org.uk>
List-Help: <mailto:cpufreq-request@lists.linux.org.uk?subject=help>
List-Subscribe: <http://lists.linux.org.uk/mailman/listinfo/cpufreq>,
	<mailto:cpufreq-request@lists.linux.org.uk?subject=subscribe>
Sender: cpufreq-bounces@lists.linux.org.uk
Errors-To: cpufreq-bounces+glkc-cpufreq=m.gmane.org+glkc-cpufreq=m.gmane.org@lists.linux.org.uk
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-acpi@vger.kernel.org, =?utf-8?q?Pawe=C5=82_Sikora?= <pluto@agmk.net>, linux-kernel@vger.kernel.org, cpufreq@lists.linux.org.uk
List-Id: linux-acpi@vger.kernel.org

On Wednesday 24 January 2007 17:52, Adrian Bunk wrote:
> On Wed, Jan 24, 2007 at 11:46:44PM +0100, Pawe=C5=82 Sikora wrote:

> > for 2.6.20rc5 i get an acpi related oops during x86-64 boot:
> > http://minus.ds14.agh.edu.pl/~pluto/2.6.20rc5-acpi-oops.jpg
> > disabling the "amd-k8 cool'n'quiet" option in bios helps.
> > moreover, it works fine for 2.6.17.13, so it looks like
> > a recent regression. i can provide more details if you need.
>=20
> thanks for your report.
>=20
> Can you narrow down a bit when it started?
> Is 2.6.19 OK?
> Is 2.6.18 OK?

Is the stack trace always the same?  It doesn't make much sense to me.

if AMD cool & quiet is enabled in the BIOS, but CONFIG_CPU_FREQ=3Dn
in the kernel, do you see the same problem?

thanks,
=2DLen
