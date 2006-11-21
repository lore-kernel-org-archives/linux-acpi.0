From: Dave Jones <davej@redhat.com>
Subject: Re: [PATCH] allow the highest frequency if bios think so.
Date: Tue, 21 Nov 2006 12:03:45 -0500
Message-ID: <20061121170345.GI17736@redhat.com>
References: <EB12A50964762B4D8111D55B764A8454E76E62@scsmsx413.amr.corp.intel.com>
	<20061121163514.GM4945@poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <cpufreq-bounces+glkc-cpufreq=m.gmane.org@lists.linux.org.uk>
Content-Disposition: inline
In-Reply-To: <20061121163514.GM4945@poupinou.org>
List-Unsubscribe: <http://lists.linux.org.uk/mailman/listinfo/cpufreq>,
	<mailto:cpufreq-request@lists.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.linux.org.uk/mailman/private/cpufreq>
List-Post: <mailto:cpufreq@lists.linux.org.uk>
List-Help: <mailto:cpufreq-request@lists.linux.org.uk?subject=help>
List-Subscribe: <http://lists.linux.org.uk/mailman/listinfo/cpufreq>,
	<mailto:cpufreq-request@lists.linux.org.uk?subject=subscribe>
Sender: cpufreq-bounces@lists.linux.org.uk
Errors-To: cpufreq-bounces+glkc-cpufreq=m.gmane.org+glkc-cpufreq=m.gmane.org@lists.linux.org.uk
To: Bruno Ducrot <ducrot@poupinou.org>
Cc: cpufreq@lists.linux.org.uk, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Nov 21, 2006 at 05:35:14PM +0100, Bruno Ducrot wrote:

 > Correct bound checking from the value returned from _PPC method.
 > 
 > Signed-off-by: Bruno Ducrot <ducrot@poupinou.org>

Looks good for me, and should go into .19
Len, do you want to push this to Linus through acpi.git ?

		Dave
 
-- 
http://www.codemonkey.org.uk
