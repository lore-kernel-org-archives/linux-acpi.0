From: Jeremy Moles <jeremy-9vekgGPT+OA7YuNMryXyOw@public.gmane.org>
Subject: General Questions:
Date: Fri, 04 Feb 2005 07:32:34 -0500
Message-ID: <1107520354.4248.16.camel@localhost>
Reply-To: jeremy-9vekgGPT+OA7YuNMryXyOw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-TtF/mJH4Jtrk1uMJSBkQmQ@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hello again ACPI gurus! Many thanks for the last tip; I was able to
decompile and "fix" the DSDT rather easily using the advice from your
responses.

I have a few questions about batteries:

I was looking around the battery driver code last night trying to find
out what the battery "alarm" actually does. Unfortuneately (and I only
spent a few minutes looking), I wasn't able to easily see what the
function of this feature was. I guess my first question is: does it do
anything at all? :)

Secondly, would it be beyond of the scope of ACPI for the battery driver
to generate ACPI events when the power gets low? Or is there already
something like this that exists that I'm missing? I tried
watching /proc/acpi/event last as my battery discharged and didn't see
any unusual activity.

Thirdly, does the kernel have access to the LED lights on a typical
laptop? That is, does it have the ability to ping the LED and make it
light up? Or, is that something controlled entirely by hardware? It
would be rather neat, I think, to use my "bluetooth" LED (since I don't
have bluetooth) in an arbitrary way.

Anyways. :)

-- 
Jeremy L. Moles
EmperorLinux
1-888-651-66
www.EmperorLinux.com
jeremy-LdSqz1EEwCk7YuNMryXyOw@public.gmane.org



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
